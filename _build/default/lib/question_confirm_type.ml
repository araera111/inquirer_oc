open Types

type question_confirm_option = {
  name : string;
  prompt_type : prompt_type;
  message : string;
  default : bool option;
}
