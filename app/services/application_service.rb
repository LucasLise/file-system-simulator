class ApplicationService
  def initialize(disco, tipo_bloco=nil, tamanho_bloco=nil)
    @disco = disco
    @tipo_bloco = tipo_bloco
    @tamanho_bloco = tamanho_bloco
  end

  def posicoes_substring(substring, string)
    substring_len = substring.size
    s = StringScanner.new(string)
    regexp = Regexp.new(Regexp.escape(substring))
    positions = []
    while s.scan_until(regexp)
      positions << (s.pos - substring_len)
    end
    positions.join ', '
  end

end
