type prompt_type =
  | Input
  | Confirm
  | List
  | Rawlist
  | Expand
  | Checkbox
  | Password
  | Editor

type choice = { word : string; value : string }

type question = {
  name : string;
  prompt_type : prompt_type;
  message : string;
  choices : choice list;
  page_size : int option;
}

type confirm = {
  name : string;
  prompt_type : prompt_type;
  message : string;
  default : bool option;
}
