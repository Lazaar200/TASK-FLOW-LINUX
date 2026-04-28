<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\TaskController;
use App\Http\Controllers\Api\CategoryController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login',    [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {

    // Auth
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me',      [AuthController::class, 'me']);

    // Users — liste pour assignation
    Route::get('/users', function(\Illuminate\Http\Request $request) {
        return response()->json(\App\Models\User::select('id','name','email')->get());
    });

    // Tasks
    Route::get('/tasks',                   [TaskController::class, 'index']);
    Route::post('/tasks',                  [TaskController::class, 'store']);
    Route::get('/tasks/{id}',              [TaskController::class, 'show']);
    Route::put('/tasks/{id}',              [TaskController::class, 'update']);
    Route::delete('/tasks/{id}',           [TaskController::class, 'destroy']);
    // CORRECTION BUG : route PATCH pour changer le statut
    Route::patch('/tasks/{id}/status',     [TaskController::class, 'updateStatus']);

    // Categories
    Route::get('/categories',              [CategoryController::class, 'index']);
    Route::post('/categories',             [CategoryController::class, 'store']);
    Route::put('/categories/{id}',         [CategoryController::class, 'update']);
    Route::delete('/categories/{id}',      [CategoryController::class, 'destroy']);
});
