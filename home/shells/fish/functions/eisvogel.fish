function eisvogel
    set input_file "$argv[1]"
    set output_file (string replace ".md" ".pdf" $input_file)
    set output_file (string lower $output_file) # Convert to lowercase

    pandoc $input_file -o $output_file --from markdown --template eisvogel --listings
end
