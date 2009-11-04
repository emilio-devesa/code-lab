(*
compilar con:
$ ocamlopt nums.cmxa fact.ml -o fact

ejecutar con:
$ ./fact n			(donde n es el numero a calcular)
*)

open Num;;

let rec fact n = if n <= 1 
				 then num_of_int n
				 else (num_of_int n */ fact (n-1));;

let fact_s n = string_of_num (fact n);;

let n = (Sys.argv.(1));;

let s = fact_s (int_of_string(n));;
print_endline (s);;
