(*
compilar con:
$ ocamlopt nums.cmxa fact_t.ml -o fact_t

ejecutar con:
$ ./fact_t n			(donde n es el numero a calcular)
*)

open Num;;

let fact n = if n = 0
			 then num_of_int 0
			 else let rec f (i, r) = if i = n
									 then num_of_int r
									 else f (i+1, r*(i+1))
				  in f (1,1);;

let fact_s n = string_of_num (fact n);;

let n = (Sys.argv.(1));;

let s = fact_s (int_of_string(n));;
print_endline (s);;
