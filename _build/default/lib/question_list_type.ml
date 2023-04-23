open Types
type choice = { word : string; value : string }

type question = {
  name : string;
  prompt_type : prompt_type;
  message : string;
  choices : choice list;
  page_size : int option;
}