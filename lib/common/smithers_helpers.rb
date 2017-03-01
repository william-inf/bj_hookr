class SmithersHelpers

	class << self
		 def get_files_in_directory(directory)
			 Dir.glob(File.join(directory, '**', '*.json'))
		 end
	end

end