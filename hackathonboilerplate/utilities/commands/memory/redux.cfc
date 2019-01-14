component {

    function run() {
 
        var colors = getColors();
        var randomColors = '';
        var memorizedColors = '';
        var gameSpeed = 500;
        var rounds = 10;
        var sequences = 1;        

        reduxIntro();
        
        var response = ask( 'Would you like to test your memory? (y or n)' );

        if( Left( response, 1 ) != 'y' ) {
            return 'Game Aborted';
        }

        for ( var round = 1; round  <= rounds; round++ ) {

            randomColors = '';
            memorizedColors = '';

            say( 'Round ' & round & ' Begin.'  );    
                            
            sleep(200);    

            for ( var i = 1; i <= sequences; i++ ) {

                var color = colors[ RandRange( 1, 4, 'SHA1PRNG' ) ];            
                randomColors = ListAppend( randomColors, color.name, ' ' ); 
                
                print['redOn'&color.name&'BlackText']( trim( color.ascii ) ); 
                say( color.name );

                sleep( gameSpeed );  
        
                command('!clear').run();

            }
        
            memorizedColors = ask( 'What was the sequence of color(s)?' );     

            if (  listToLetters( memorizedColors ) EQ listToLetters( randomColors ) ) {
                        
                    say( 'Correct.' );
                    print.greenTextline('The correct sequence is: ' & randomColors);    
                    print.blueTextline('You entered: ' & memorizedColors);
                    
                    if( round NEQ rounds ) {
                        var response = ask('Do you wish to proceed to the next round? ( y or n )');
                    
                    
                        if( Left( response, 1 ) == 'y' ) {

                            sequences = sequences + 1;

                        }
                        else {

                            say( 'Game Over' );    
                            return 'Game Over';

                        }
                    }                        
            }
            else {

                say('That is incorrect.');

                print.redTextline('That is incorrect.');  
                print.greenTextline('The correct sequence is: ' & randomColors);    
                print.redTextline('You entered: ' & memorizedColors); 
                
                var response = ask( ' Would you like to try again? (y or n)' );    

                if( Left( response, 1 ) == 'y' ) {

                    round = round; 
                    sequences = sequences;   

                }

                else {

                    say( 'Game Over' );
                    return 'Game Over';

                }               

            }
        }    

        say('Congratulations!  You have conquered Redux.');
        return 'Player Wins.';

    }

    function reduxIntro() {

        print.redTextline("


                    _____               _                
                   |  __ \             | |               
                   | |__) |   ___    __| |  _   _  __  __
                   |  _  /   / _ \  / _` | | | | | \ \/ /
                   | | \ \  |  __/ | (_| | | |_| |  >  < 
                   |_|  \_\  \___|  \__,_|  \__,_| /_/\_\
                                
        ");

        say( 'Welcome to Redux.'  );    
        
        print.Line( 'Redux is a memory game where you have to remember a sequence of colors.' );
        print.Line('');
        print.Line( 'The Rules are : '); 
        print.Line( '           Entries can be the full name of the color in a sequence.' );
        print.Line( '           Entries can be the first letter of the colors in a sequence.' );
        print.Line( '           Entries must be delimited by a space.');
        print.Line('');

    }

    function say( statement ) {

        command( '!say' )
            .params( statement )
            .run();        

    }

    function listToLetters( list ) {

        var letterList = '';

        for ( var pos = 1; pos <= listLen( list, ' ', true ); pos++ ) {

             letterList = listAppend( letterList, Left( listGetAt( list,pos,' ', true ), 1 ), ' ' );

        }    

        return letterList;

    }

    function getColors() {

        return [
                    {

                        name  : "blue",
                        ascii : "
                    ____  _                 
                    |  _ \| |                
                    | |_) | |_   _  ___      
                    |  _ <| | | | |/ _ \     
                    | |_) | | |_| |  __/     
                    |____/|_|\__,_|\___|     
                                            
                                "
                    },
                    {

                        name  : "red",
                        ascii : "
                    _____          _      
                    |  __ \        | |     
                    | |__) |___  __| |     
                    |  _  // _ \/ _` |     
                    | | \ \  __/ (_| |     
                    |_|  \_\___|\__,_|     
                                            
                                "

                    },
                    {
                        name  : "yellow",
                        ascii : "
                      __     __  _ _                    
                      \ \   / / | | |                   
                       \ \_/ /__| | | _____      __     
                        \   / _ \ | |/ _ \ \ /\ / /     
                        | |  __/ | | (_) \ V  V /      
                        |_|\___|_|_|\___/ \_/\_/       
                                                        
                                                        
                                "
                        
                    },
                    {

                        name  : "green",
                        ascii : "
                        _____                          
                    / ____|                         
                    | |  __ _ __ ___  ___ _ __       
                    | | |_ | '__/ _ \/ _ \ '_ \      
                    | |__| | | |  __/  __/ | | |     
                    \_____|_|  \___|\___|_| |_|     
                                                    
                                                    
                                "   

                    }


                ];

    }


}