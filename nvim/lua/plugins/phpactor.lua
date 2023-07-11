return {
    'gbprod/phpactor.nvim',
    dependencies = {
        {
            'phpactor/phpactor',
            branch = 'master',
            ft = 'php',
            run = 'composer install --no-dev -o',
            build = 'composer install --no-dev -o',
            config = function()
                require('phpactor').setup()
            end,
        },
    },
}
