#region this is a region you may close or open me with ctrl+m ctrl+u
/*
Marcelo "S". A. N. MULTIPLAYER GAME FORSTWINTER phase 1

this tutorial will guide us through a few phases of making a working multiplayer experience.

phase 1 will be the connection only 
phase 2 will be the simple moviment of players and synch of those
phase 3 will be more complex exchange of data and testing of game mechanics
phase 4 will be the complete game itself


a few quirks to note

most variabless declared by me will have a handler , usually 'slv'
which stands for 'S. Local Var' 
it is used for my own organization,but also will help you see which variables arent created and are default of the gml ,
with that said it will usually go as:

"S??_ourdefinedname"

first 'S' will be always "S"

first '?' will be the scope of the variable (L Local, G Global,F Father, T Temporary,P Public etc...

second '?' will be the type of variable (V - 'var' general variable of gml , F - function , A - Array, etc...

so slf_step_update means its a Local Function defined by us, and will probably be located on the create event of the object it is

sgf_anothername is a Global Function and will be located on the script_global_vars_and_functions


this project will use extensively #region #endregion for clarity , use ctrl+m (or right click > region) with the text editor selected, for a better experience

*/
#endregion