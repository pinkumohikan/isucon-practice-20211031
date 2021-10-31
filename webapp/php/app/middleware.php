<?php

declare(strict_types=1);

use Slim\App;
use App\Application\Middleware\AccessLog;

return function (App $app) {
    $app->add(AccessLog::class);
    $app->add(new \Slim\Middleware\SessionCookie([
        'expires' => '20 minutes',
        'path' => '/',
        'domain' => null,
        'secure' => false,
        'httponly' => false,
        'name' => 'slim_session',
        'secret' => 'tin2',
        'cipher' => MCRYPT_RIJNDAEL_256,
        'cipher_mode' => MCRYPT_MODE_CBC
    ]));
};
