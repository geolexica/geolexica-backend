# (c) Copyright 2020 Ribose Inc.
#

RSpec.describe ::Jekyll::Geolexica::Math do
  subject { described_class }

  describe "#convert" do
    subject { described_class.method(:convert) }

    let(:converter_dbl) { described_class::Converter.clone }

    before { stub_const described_class::Converter.name, converter_dbl }

    it "performs specified conversion by using Converter helper object" do
      converter_dbl.define_method "format1_to_format2" do |expr|
        "converted_#{expr}"
      end

      retval = subject.("expr", from: :format1, to: :format2)

      expect(retval).to eq("converted_expr")
    end
  end

  describe "LaTeX math to MathML conversion" do
    subject do
      ->(expr) { described_class.convert(expr, from: :latexmath, to: :mathml) }
    end

    it "converts most simplistic expressions" do
      expr = 'E = mc^2'
      retval = subject.(expr)

      expect(retval).to be_a(String)
      expect(retval).not_to be_empty

      expect(retval).to start_with('<?xml version="1.0" encoding="UTF-8"?>')
      expect(retval).to include('<math')
      expect(retval).to include('<mi>E</mi>')
      expect(retval).to include('<mo>=</mo>')
      expect(retval).to include('<msup>')
      expect(retval).to include('<mi>c</mi>')
      expect(retval).to include('<mn>2</mn>')
    end

    it "handles features from amsmath package" do
      # \text is an example of AMS math feature
      expr = '\Delta \text{is a Greek letter}'
      retval = subject.(expr)

      expect(retval).to be_a(String)
      expect(retval).not_to be_empty

      expect(retval).to include('<math')
      expect(retval).not_to include('<merror')
      expect(retval).to include('<mtext>is a Greek letter</mtext>')
    end

    it "handles features from amssymb package" do
      # \geqslant is an example of AMS symbol
      expr = '\Delta x \Delta p_x \geqslant \frac{\hbar}{2}'
      retval = subject.(expr)

      expect(retval).to be_a(String)
      expect(retval).not_to be_empty

      expect(retval).to include('<math')
      expect(retval).not_to include('<merror')
      expect(retval).to include('<mo>⩾</mo>')
    end
  end
end
