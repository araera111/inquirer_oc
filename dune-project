(lang dune 3.7)

(name inquirer_oc)
(version 1.0.15)

(generate_opam_files true)

(source
 (github araera111/inquirer_oc))

(authors "Ou Fumio")

(maintainers "Ou Fumio")

(license MIT)

(documentation https://github.com/araera111/inquirer_oc/#README)

(package
 (name inquirer_oc)
 (synopsis "A collection of common interactive command line user interfaces")
 (description "A collection of common interactive command line user interfaces")
 (depends ocaml dune)
 (tags
  (answer answers ask base cli command command-line confirm enquirer generate generator hyper input inquire inquirer)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
