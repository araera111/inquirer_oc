open Types

type question_input_option = {
  name : string;
  prompt_type : prompt_type;
  message : string;
  default : string option;
}
