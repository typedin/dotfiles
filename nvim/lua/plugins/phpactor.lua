return {
    'phpactor/phpactor',
    ft = 'php',
    build = 'composer install --no-dev --optimize-autoloader',
    keys = {
        {
            '<LocalLeader>pm',
            ':PhpactorContextMenu<CR>',
        },
        {
            '<LocalLeader>pn',
            ':PhpactorClassNew<CR>',
        },
    },
}
