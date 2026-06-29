<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Step 1: Restore countries table if needed
        $this->repairCountries();
        $this->repairStates();
        $this->repairCities();

        // Step 2: Build ID maps
        $countryMap = $this->buildCountryMap();
        $stateMap = $this->buildStateMap();

        // Step 3: Consolidate
        $this->consolidateCountries($countryMap);
        $this->consolidateStates($countryMap, $stateMap);
        $this->consolidateCities($countryMap, $stateMap);
    }

    private function repairCountries(): void
    {
        if (!Schema::hasColumn('countries', 'language_id')) {
            Schema::table('countries', function (Blueprint $t) {
                $t->bigInteger('language_id')->nullable();
                $t->string('name', 255)->nullable();
            });
        }
        // Remove empty records created by failed migration
        DB::table('countries')->whereNull('name')->whereNull('language_id')->delete();

        // Restore from SQL
        $restored = DB::table('countries')->whereNotNull('name')->count();
        if ($restored > 0) return; // Data still exists

        // Restore data from installer SQL
        $sql = file_get_contents(__DIR__ . '/../../public/installer/database.sql');
        preg_match('/INSERT INTO `countries`.*?;/s', $sql, $m);
        if (!empty($m[0])) {
            DB::unprepared($m[0]);
        }
    }

    private function repairStates(): void
    {
        // Remove empty state records from failed migration
        DB::table('states')->whereNull('name')->delete();

        $restored = DB::table('states')->whereNotNull('name')->count();
        if ($restored > 0) return;

        $sql = file_get_contents(__DIR__ . '/../../public/installer/database.sql');
        preg_match('/INSERT INTO `states`.*?;/s', $sql, $m);
        if (!empty($m[0])) {
            DB::unprepared($m[0]);
        }
    }

    private function repairCities(): void
    {
        DB::table('cities')->whereNull('name')->delete();
        DB::table('cities')->whereNull('language_id')->delete();

        $restored = DB::table('cities')->whereNotNull('name')->count();
        if ($restored > 0) return;

        $sql = file_get_contents(__DIR__ . '/../../public/installer/database.sql');
        preg_match('/INSERT INTO `cities`.*?;/s', $sql, $m);
        if (!empty($m[0])) {
            DB::unprepared($m[0]);
        }
    }

    private function getLanguages(): \Illuminate\Support\Collection
    {
        return DB::table('languages')->orderBy('id')->get();
    }

    private function getBaseLanguage(): object
    {
        return DB::table('languages')->where('is_default', 1)->first()
            ?? DB::table('languages')->where('code', 'en')->first()
            ?? DB::table('languages')->first();
    }

    private function buildCountryMap(): array
    {
        $map = [];
        $baseLang = $this->getBaseLanguage();
        $languages = $this->getLanguages();
        $byLang = [];
        foreach ($languages as $lang) {
            $byLang[$lang->id] = DB::table('countries')
                ->where('language_id', $lang->id)->orderBy('id')->get()->values();
        }
        $max = collect($byLang)->map(fn($c) => count($c))->max();
        for ($i = 0; $i < $max; $i++) {
            $base = $byLang[$baseLang->id][$i] ?? null;
            if (!$base) {
                foreach ($languages as $lang) { $base = $byLang[$lang->id][$i] ?? null; if ($base) break; }
            }
            if (!$base) continue;
            foreach ($languages as $lang) {
                $old = $byLang[$lang->id][$i] ?? null;
                if ($old && $old->id !== $base->id) $map[$old->id] = $base->id;
            }
        }
        return $map;
    }

    private function buildStateMap(): array
    {
        $map = [];
        $baseLang = $this->getBaseLanguage();
        $languages = $this->getLanguages();
        $byLang = [];
        foreach ($languages as $lang) {
            $byLang[$lang->id] = DB::table('states')
                ->where('language_id', $lang->id)->orderBy('id')->get()->values();
        }
        $max = collect($byLang)->map(fn($c) => count($c))->max();
        for ($i = 0; $i < $max; $i++) {
            $base = $byLang[$baseLang->id][$i] ?? null;
            if (!$base) {
                foreach ($languages as $lang) { $base = $byLang[$lang->id][$i] ?? null; if ($base) break; }
            }
            if (!$base) continue;
            foreach ($languages as $lang) {
                $old = $byLang[$lang->id][$i] ?? null;
                if ($old && $old->id !== $base->id) $map[$old->id] = $base->id;
            }
        }
        return $map;
    }

    private function consolidateCountries(array $countryMap): void
    {
        $baseLang = $this->getBaseLanguage();
        $languages = $this->getLanguages();
        $byLang = [];
        foreach ($languages as $lang) {
            $byLang[$lang->id] = DB::table('countries')
                ->where('language_id', $lang->id)->orderBy('id')->get()->values();
        }
        $max = collect($byLang)->map(fn($c) => count($c))->max();

        for ($i = 0; $i < $max; $i++) {
            $base = $byLang[$baseLang->id][$i] ?? null;
            if (!$base) {
                foreach ($languages as $lang) { $base = $byLang[$lang->id][$i] ?? null; if ($base) break; }
            }
            if (!$base) continue;

            $keepId = $base->id;

            foreach ($languages as $lang) {
                $old = $byLang[$lang->id][$i] ?? null;
                if (!$old) continue;
                DB::table('country_contents')->updateOrInsert(
                    ['country_id' => $keepId, 'language_id' => $lang->id],
                    ['name' => $old->name, 'created_at' => now(), 'updated_at' => now()]
                );
            }
        }

        $this->applyReplacements('countries', $countryMap);
        $this->dropColumns('countries');
    }

    private function consolidateStates(array $countryMap, array $stateMap): void
    {
        $baseLang = $this->getBaseLanguage();
        $languages = $this->getLanguages();
        $byLang = [];
        foreach ($languages as $lang) {
            $byLang[$lang->id] = DB::table('states')
                ->where('language_id', $lang->id)->orderBy('id')->get()->values();
        }
        $max = collect($byLang)->map(fn($c) => count($c))->max();

        for ($i = 0; $i < $max; $i++) {
            $base = $byLang[$baseLang->id][$i] ?? null;
            if (!$base) {
                foreach ($languages as $lang) { $base = $byLang[$lang->id][$i] ?? null; if ($base) break; }
            }
            if (!$base) continue;

            $keepId = $base->id;
            $newCountryId = $countryMap[$base->country_id] ?? $base->country_id;
            DB::table('states')->where('id', $keepId)->update(['country_id' => $newCountryId]);

            foreach ($languages as $lang) {
                $old = $byLang[$lang->id][$i] ?? null;
                if (!$old) continue;
                DB::table('state_contents')->updateOrInsert(
                    ['state_id' => $keepId, 'language_id' => $lang->id],
                    ['name' => $old->name, 'created_at' => now(), 'updated_at' => now()]
                );
            }
        }

        $this->applyReplacements('states', $stateMap);
        $this->dropColumns('states');
    }

    private function consolidateCities(array $countryMap, array $stateMap): void
    {
        $baseLang = $this->getBaseLanguage();
        $languages = $this->getLanguages();
        $byLang = [];
        foreach ($languages as $lang) {
            $byLang[$lang->id] = DB::table('cities')
                ->where('language_id', $lang->id)->orderBy('id')->get()->values();
        }
        $max = collect($byLang)->map(fn($c) => count($c))->max();

        $cityReplacements = [];

        for ($i = 0; $i < $max; $i++) {
            $base = $byLang[$baseLang->id][$i] ?? null;
            if (!$base) {
                foreach ($languages as $lang) { $base = $byLang[$lang->id][$i] ?? null; if ($base) break; }
            }
            if (!$base) continue;

            $keepId = $base->id;
            DB::table('cities')->where('id', $keepId)->update([
                'country_id' => $countryMap[$base->country_id] ?? $base->country_id,
                'state_id' => $base->state_id ? ($stateMap[$base->state_id] ?? $base->state_id) : null,
            ]);

            $featureImage = $base->feature_image;
            if (!$featureImage) {
                foreach ($languages as $lang) {
                    $candidate = $byLang[$lang->id][$i] ?? null;
                    if ($candidate && $candidate->feature_image) {
                        $featureImage = $candidate->feature_image;
                        DB::table('cities')->where('id', $keepId)->update(['feature_image' => $featureImage]);
                        break;
                    }
                }
            }

            foreach ($languages as $lang) {
                $old = $byLang[$lang->id][$i] ?? null;
                if (!$old) continue;
                if ($old->id !== $keepId) $cityReplacements[$old->id] = $keepId;
                DB::table('city_contents')->updateOrInsert(
                    ['city_id' => $keepId, 'language_id' => $lang->id],
                    ['name' => $old->name, 'slug' => $old->slug, 'created_at' => now(), 'updated_at' => now()]
                );
            }
        }

        foreach ($cityReplacements as $oldId => $newId) {
            DB::table('listing_contents')->where('city_id', $oldId)->update(['city_id' => $newId]);
        }
        $deleteIds = array_keys($cityReplacements);
        if (!empty($deleteIds)) DB::table('cities')->whereIn('id', $deleteIds)->delete();

        $this->dropColumns('cities');
    }

    private function applyReplacements(string $table, array $replacements): void
    {
        if (empty($replacements)) return;
        $idsToDelete = array_keys($replacements);

        foreach ($replacements as $oldId => $newId) {
            if ($table === 'countries') {
                DB::table('listing_contents')->where('country_id', $oldId)->update(['country_id' => $newId]);
                DB::table('states')->where('country_id', $oldId)->update(['country_id' => $newId]);
                DB::table('cities')->where('country_id', $oldId)->update(['country_id' => $newId]);
            } else {
                DB::table('listing_contents')->where('state_id', $oldId)->update(['state_id' => $newId]);
                DB::table('cities')->where('state_id', $oldId)->update(['state_id' => $newId]);
            }
        }

        DB::table($table)->whereIn('id', $idsToDelete)->delete();
    }

    private function dropColumns(string $table): void
    {
        $cols = ['language_id', 'name'];
        if ($table === 'cities') $cols[] = 'slug';
        foreach ($cols as $col) {
            if (Schema::hasColumn($table, $col)) {
                Schema::table($table, function (Blueprint $t) use ($col) { $t->dropColumn($col); });
            }
        }
    }

    public function down(): void
    {
        foreach (['countries', 'states'] as $table) {
            Schema::table($table, function (Blueprint $t) {
                $t->bigInteger('language_id')->nullable(); $t->string('name', 255)->nullable();
            });
        }
        Schema::table('cities', function (Blueprint $t) {
            $t->bigInteger('language_id')->nullable(); $t->string('name', 255)->nullable(); $t->string('slug', 255)->nullable();
        });
        foreach (DB::table('country_contents')->get() as $cc) {
            DB::table('countries')->where('id', $cc->country_id)->update(['language_id' => $cc->language_id, 'name' => $cc->name]);
        }
        foreach (DB::table('state_contents')->get() as $sc) {
            DB::table('states')->where('id', $sc->state_id)->update(['language_id' => $sc->language_id, 'name' => $sc->name]);
        }
        foreach (DB::table('city_contents')->get() as $cc) {
            DB::table('cities')->where('id', $cc->city_id)->update(['language_id' => $cc->language_id, 'name' => $cc->name, 'slug' => $cc->slug]);
        }
    }
};
