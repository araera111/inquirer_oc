# inquirer_oc

v1.0.8

## What does "inquirer_oc" library do?

Allow interaction on the CLI For example, you can have the user select one from multiple lists.

Currently, three types of question formats are implemented.

1. list
2. input
3. confirm

## usage

1. list

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
