<?php

use Illuminate\Foundation\Application;
use Illuminate\Http\Request;

define('LARAVEL_START', microtime(true));

// The API is served under <host>/XX_SERVER_MODULE/BACKEND (spec requires a
// subpath with no port and no /public suffix). Strip that prefix the same way
// an nginx/Apache rewrite rule would, so Laravel routes stay at /api/v1/*.
$requestUri = urldecode($_SERVER['REQUEST_URI'] ?? '/');
$backendBase = '/XX_SERVER_MODULE/BACKEND';
if (str_starts_with($requestUri, $backendBase)) {
    $stripped = substr($requestUri, strlen($backendBase));
    $_SERVER['REQUEST_URI'] = $stripped === '' || $stripped === false ? '/' : $stripped;
}

// Determine if the application is in maintenance mode...
if (file_exists($maintenance = __DIR__.'/../storage/framework/maintenance.php')) {
    require $maintenance;
}

// Register the Composer autoloader...
require __DIR__.'/../vendor/autoload.php';

// Bootstrap Laravel and handle the request...
/** @var Application $app */
$app = require_once __DIR__.'/../bootstrap/app.php';

$app->handleRequest(Request::capture());
