def verificere_streng(variable, example)
  if !ENV[variable]
    puts
    puts "Venligst giv en '#{variable}' variabel, f.eks."
    puts "export #{variable}=#{example}"
    puts
    exit
  end
end

def verificere_fil(variable, example)
  verificere_streng(variable, example)
  begin
    File.read(ENV[variable])
  rescue Errno::ENOENT => e
    puts
    puts "Kunne ikke læse '#{variable}' filen tilsyneladende på #{ENV[variable]}"
    puts "Sørg for, at denne fil eksisterer, eller eksport en ny placering, f.eks."
    puts "export #{variable}=#{example}"
    puts
    exit
  end
end

verificere_fil('GOOGLE_APPLICATION_CREDENTIALS', '~/key.json')
