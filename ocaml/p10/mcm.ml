(* PRACTICA 10 *)

(* Implementar programa mcm *)

(*
compilar con:
$ ocamlopt mcm.ml -o mcm

ejecutar con:
$ ./mcm a b		(a y b los numeros de los que calcular el mcm)
*)

(* El mcm se calcula dividiendo el producto de dos numeros a y b entre
   su mcd. El mcd se ha calculado con el algoritmo de Euclides. *)

let a = int_of_string (Sys.argv.(1));;
let b = int_of_string (Sys.argv.(2));;

let a = max a b and b = min a b;;

let rec mcd a b = match (a,b) with
			(a, 0) -> a
			| _ -> mcd b (a mod b);;

print_endline (string_of_int ((a*b)/(mcd a b)));;
