#!/bin/bash
#
# track registered OTN datasets and generate dataset summaries
#

function track_datasets {
  preston track "https://opentraits.org/datasets.json"\
  | grep hasVersion\
  | grep http\
  | preston cat\
  | jq --raw-output .datasets[].contentURL\
  | grep http\
  | xargs preston track
}

function track_and_resolve_taxa {
  track_datasets\
  | preston grep -l tsv -o "[A-Z][a-z]+[ ,_]+[a-z]{2,}"\
  | grep value\
  | cut -f1,3\
  | nomer replace globi-correct\
  | nomer append col\
  | grep -v NONE
}

track_datasets

