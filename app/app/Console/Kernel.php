<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Illuminate\Support\Facades\Artisan;

class Kernel extends ConsoleKernel
{
  protected $commands = [
    //
  ];

  protected function schedule(Schedule $schedule)
  {
    $schedule->command('listings:translate')->everyMinute();
    $schedule->command('categories:translate')->everyMinute();

    $schedule->call(function () {
      Artisan::call('subcheck:expired');
    })->dailyAt('00:00');
  }

  /**
   * Register the commands for the application.
   *
   * @return void
   */
  protected function commands()
  {
    $this->load(__DIR__ . '/Commands');

    require base_path('routes/console.php');
  }
}
