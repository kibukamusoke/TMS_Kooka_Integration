<?php
session_start();
ob_start();
$_CONFIG = array(
    'Database' => array( // mysql or postgre
        'DB_host' => '52.25.250.37',
        'DB_user' => 'root',
        'DB_pass' => 'kooka',
        'DB_name' => 'kooka',
        'DB_prefix' => '',
        'DB_port' => 9010
    ),
    'CONSTANTS' => array()
);

?>