(* PRACTICA 10 *)

(* Implementar programa echo *)

(*
compilar con:
$ ocamlopt echo.ml -o echo

ejecutar con:
$ ./echo y terminar con CTRL+D
*)

let rec bucle () = 
    print_endline (read_line ()); 
    bucle ();;
    
try bucle () with End_of_file -> ();;
