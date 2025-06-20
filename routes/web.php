<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AIController;
use App\Livewire\Search;


Route::get('/dfghj', [AIController::class, 'index'])->name('home');

Route::post('/ask', [AIController::class, 'answer'])->name('ask');

Route::get('/', Search::class);
