(* PRACTICA 10 *)

(* Implementar programa mcd *)

(*
compilar con:
$ ocamlopt mcd.ml -o mcd

ejecutar con:
$ ./mcd a b		(a y b los numeros de los que calcular el mcd)
*)

(* El mcd de dos numeros a y b se puede calcular de forma sencilla con
   el algoritmo de Euclides. *)

let a = int_of_string (Sys.argv.(1));;
let b = int_of_string (Sys.argv.(2));;

let a = max a b and b = min a b;;

let rec mcd a b = match (a,b) with
			(a, 0) -> print_endline (string_of_int a)
			| _ -> mcd b (a mod b);;

mcd a b;;
