(*
compilar con:
$ ocamlopt nums.cmxa fib.ml -o fib

ejecutar con:
$ ./fib n			(donde n es el numero a calcular)
*)

open Num;;

let rec fib n = if n < 2
				then num_of_int n
				else (fib (n-1) +/ fib (n-2));;

let fib_s n = string_of_num (fib n);;

let n = (Sys.argv.(1));;

let s = fib_s (int_of_string(n));;
print_endline (s);;
