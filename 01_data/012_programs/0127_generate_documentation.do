*==============================================================================*
* 0127 SUBTASK: AUTO GENERATE DOCUMENTATION FROM EDUKIT_SAVE WITH METADATA
*==============================================================================*
qui {

  *-----------------------------------------------------------------------------
  * Autogenerated documentation (markdown files) from edukit_save
  *-----------------------------------------------------------------------------

  * Whether we generate documentation for each .dta or no depends on Stata version
  * for dyntext was only implemented in version 15.
  * It also requires that edukit_save was being used to save files
  local generate_documentation = ( c(version)>=15  &  $use_edukit_save )

  * List of files for which edukit_save_metadata is implemented
  local files_saved_with_metadata "population proficiency enrollment rawfull rawlatest"

  * Location of those files in the clone
  local file_path "${clone}/01_data/013_outputs/"

  * Location to save the autogenerated tables and to find the dyntext script
  local doc_path "${clone}/00_documentation/002_repo_structure/0022_dataset_tables"


  * If it was verified that documentation can be generated
  if `generate_documentation'==1 {

    * Must be in the folder where dyntext scrip is found
    cd "`doc_path'"

    * Loop through the files with metadata
    foreach filename of local files_saved_with_metadata {

      * Open the file and document it
      use "`file_path'/`filename'.dta", clear
      noi dyntext "dyntext_LP.txt", saving("`doc_path'/`filename'.md") replace
    }

    noi disp as res "{phang}Create documentation for datasets: `files_saved_with_metadata'.{p_end}"
  }

  else noi disp as err "{phang}Was not able to create documentation for datasets: `files_saved_with_metadata'.{p_end}"

}
