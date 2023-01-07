return {
  create_file_if_missing = true,
  mappings = {
		{
			pattern = "(.*).go$",
      target = "%1_test.go",
		},
		{
      pattern = "(.*)_test.go$",
      target = "%1.go",
		}
	}
}
