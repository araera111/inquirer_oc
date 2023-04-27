# inquirer_oc

## What does "inquirer_oc" library do?

Allow interaction on the CLI For example, you can have the user select one from multiple lists.

Currently, three types of question formats are implemented.

1. list
2. input
3. confirm

## usage

### list

```ocaml
open Inquirer_oc

let question_option : Question_list_type.question =
  {
    name = "flower";
    prompt_type = List;
    message = "What's your favorite flower?";
    choices =
      [
        { word = "Sunflower"; value = "sunflower" };
        { word = "Tulip"; value = "tulip" };
        { word = "Rose"; value = "rose" };
        { word = "Daisy"; value = "daisy" };
        { word = "Lily"; value = "lily" };
      ];
    page_size = Some 5;
  }

let result = Question_list.list_question question_option
let () = print_endline result
```

image
![result](https://user-images.githubusercontent.com/63596736/234867615-898a0409-f8c8-4add-af13-00be0afd5ffe.png)

#### advanced

If you want a simple string list with word and value together, there is a function to convert.

```ocaml
open Inquirer_oc

(* string list *)
let flower_list = [ "sunflower"; "tulip"; "rose"; "daisy"; "lily" ]

let question_option : Question_list_type.question =
  {
    name = "flower";
    prompt_type = List;
    message = "What's your favorite flower?";
    (* convert choices string x -> {word: x; value: x} *)
    choices = Question_list.string_list_to_choice_list flower_list;
    page_size = Some 5;
  }

let result = Question_list.list_question question_option
let () = print_endline result
```

### input

```ocaml
open Inquirer_oc

let question_option : Question_input_type.question_input_option =
  {
    name = "flower";
    prompt_type = Input;
    message = "What's your favorite flower?";
    default = Some "rose";
  }

let result = Question_input.question_input question_option
let () = print_endline result
```

image
![result](https://user-images.githubusercontent.com/63596736/234869587-d8d063b2-9154-4f4b-b391-c70de2916736.png)

### confirm

```ocaml
open Inquirer_oc

let question_option : Question_confirm_type.question_confirm_option =
  {
    name = "confirm";
    message = "Are you sure?";
    prompt_type = Confirm;
    default = Some true;
  }

let result = Question_confirm.inquirer_confirm question_option
let () = print_string (string_of_bool result)
```

image
![result](https://user-images.githubusercontent.com/63596736/234873340-2405d7cc-0177-43fe-aa4f-792b80b2d368.png)
