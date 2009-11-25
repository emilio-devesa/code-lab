(*
compilar con:
$ ocamlopt nums.cmxa fib_t.ml -o fib_t

ejecutar con:
$ ./fib_t n			(donde n es el numero a calcular)
*)

open Num;;

let fib n = if n < 2
			then num_of_int n
			else let rec f (i, r, s) = 	if i = n
										then num_of_int (r+s)
										else f (i+1, r+s, r)
				 in f (2,1,0);;

let fib_s n = string_of_num (fib n);;

let n = (Sys.argv.(1));;

let s = fib_s (int_of_string(n));;
print_endline (s);;
