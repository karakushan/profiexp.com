<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class TurkeyLocationSeeder extends Seeder
{
    public function run(): void
    {
        $ru = 23;
        $now = now();

        $countryId = DB::table('countries')->insertGetId([
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('country_contents')->insert([
            'country_id' => $countryId,
            'language_id' => $ru,
            'name' => 'Турция',
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        $provinces = [
            ['name' => 'Стамбул', 'slug' => 'istanbul', 'cities' => ['Стамбул', 'Кадыкёй', 'Бешикташ', 'Ускюдар', 'Багдаджылар']],
            ['name' => 'Анкара', 'slug' => 'ankara', 'cities' => ['Анкара', 'Чанкая', 'Кечиорен', 'Мамак', 'Синджан']],
            ['name' => 'Измир', 'slug' => 'izmir', 'cities' => ['Измир', 'Буджа', 'Конак', 'Каршияка', 'Борнова']],
            ['name' => 'Анталья', 'slug' => 'antalya', 'cities' => ['Анталья', 'Аланья', 'Кемер', 'Манавгат', 'Серик']],
            ['name' => 'Бурса', 'slug' => 'bursa', 'cities' => ['Бурса', 'Нилюфер', 'Йылдырым', 'Османгази', 'Гемлик']],
            ['name' => 'Адана', 'slug' => 'adana', 'cities' => ['Адана', 'Сейхан', 'Чукурова', 'Юрегир', 'Сарычам']],
            ['name' => 'Газиантеп', 'slug' => 'gaziantep', 'cities' => ['Газиантеп', 'Шахинбей', 'Шехиткамиль', 'Низип', 'Ислахие']],
            ['name' => 'Конья', 'slug' => 'konya', 'cities' => ['Конья', 'Сельчуклу', 'Мерам', 'Каратай', 'Эрегли']],
            ['name' => 'Мерсин', 'slug' => 'mersin', 'cities' => ['Мерсин', 'Тарсус', 'Силифке', 'Эрдемли', 'Анамур']],
            ['name' => 'Шанлыурфа', 'slug' => 'sanliurfa', 'cities' => ['Шанлыурфа', 'Акчакале', 'Сиверек', 'Суруч', 'Бирюджек']],
            ['name' => 'Диярбакыр', 'slug' => 'diyarbakir', 'cities' => ['Диярбакыр', 'Баглар', 'Каяпынар', 'Енишехир', 'Сур']],
            ['name' => 'Самсун', 'slug' => 'samsun', 'cities' => ['Самсун', 'Атакум', 'Илькадым', 'Джаник', 'Бафра']],
            ['name' => 'Кайсери', 'slug' => 'kayseri', 'cities' => ['Кайсери', 'Меликгази', 'Коджасинан', 'Талас', 'Девели']],
            ['name' => 'Эскишехир', 'slug' => 'eskisehir', 'cities' => ['Эскишехир', 'Тепебаши', 'Одунпазары', 'Чифтелер']],
            ['name' => 'Трабзон', 'slug' => 'trabzon', 'cities' => ['Трабзон', 'Акчаабат', 'Йомра', 'Арсин', 'Бешикдюзю']],
            ['name' => 'Малатья', 'slug' => 'malatya', 'cities' => ['Малатья', 'Батталгази', 'Ешильюрт', 'Акчадаг', 'Доганшехир']],
            ['name' => 'Эрзурум', 'slug' => 'erzurum', 'cities' => ['Эрзурум', 'Якутие', 'Паландёкен', 'Ашкале', 'Олту']],
            ['name' => 'Ван', 'slug' => 'van', 'cities' => ['Ван', 'Ипекьолу', 'Эдремит', 'Эрджиш', 'Мурадие']],
            ['name' => 'Маниса', 'slug' => 'manisa', 'cities' => ['Маниса', 'Шехзаделер', 'Юнусемре', 'Акхисар', 'Сома']],
            ['name' => 'Айдын', 'slug' => 'aydin', 'cities' => ['Айдын', 'Эфелер', 'Назилли', 'Сёке', 'Кушадасы']],
            ['name' => 'Мугла', 'slug' => 'mugla', 'cities' => ['Мугла', 'Фетхие', 'Мармарис', 'Бодрум', 'Даламан']],
            ['name' => 'Денизли', 'slug' => 'denizli', 'cities' => ['Денизли', 'Памуккале', 'Мерикефенди', 'Аджыпаям']],
            ['name' => 'Хатай', 'slug' => 'hatay', 'cities' => ['Антакья', 'Искендерун', 'Дефне', 'Самандаг', 'Кыркхан']],
            ['name' => 'Коджаэли', 'slug' => 'kocaeli', 'cities' => ['Измит', 'Гебзе', 'Дериндже', 'Гёльджюк', 'Кёрфез']],
            ['name' => 'Сакарья', 'slug' => 'sakarya', 'cities' => ['Адапазары', 'Сердиван', 'Хендек', 'Эренлер']],
            ['name' => 'Текирдаг', 'slug' => 'tekirdag', 'cities' => ['Текирдаг', 'Чорлу', 'Сюлейманпаша', 'Эргене', 'Капаклы']],
            ['name' => 'Эдирне', 'slug' => 'edirne', 'cities' => ['Эдирне', 'Кешан', 'Узункёпрю', 'Ипсала']],
            ['name' => 'Балыкесир', 'slug' => 'balikesir', 'cities' => ['Балыкесир', 'Эдремит', 'Бандырма', 'Гёнен', 'Айвалык']],
            ['name' => 'Чанаккале', 'slug' => 'canakkale', 'cities' => ['Чанаккале', 'Бурханье', 'Гелиболу', 'Бига', 'Эджеабат']],
            ['name' => 'Мардин', 'slug' => 'mardin', 'cities' => ['Мардин', 'Кызылтепе', 'Артуклу', 'Мидьят', 'Нусайбин']],
        ];

        foreach ($provinces as $province) {
            $stateId = DB::table('states')->insertGetId([
                'country_id' => $countryId,
                'created_at' => $now,
                'updated_at' => $now,
            ]);

            DB::table('state_contents')->insert([
                'state_id' => $stateId,
                'language_id' => $ru,
                'name' => $province['name'],
                'created_at' => $now,
                'updated_at' => $now,
            ]);

            foreach ($province['cities'] as $cityName) {
                $slug = Str::slug($cityName);
                $cityId = DB::table('cities')->insertGetId([
                    'country_id' => $countryId,
                    'state_id' => $stateId,
                    'feature_image' => null,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]);

                DB::table('city_contents')->insert([
                    'city_id' => $cityId,
                    'language_id' => $ru,
                    'name' => $cityName,
                    'slug' => $slug,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]);
            }
        }

        $this->command->info('Turkey locations seeded: 1 country, ' . count($provinces) . ' states, ' . DB::table('city_contents')->count() . ' cities');
    }
}
