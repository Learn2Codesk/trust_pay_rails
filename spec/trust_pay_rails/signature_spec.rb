require 'trust_pay_rails'

describe TrustPayRails::Signature do
  before :each do
    described_class.key = 'abcd1234'
  end

  describe '#sign' do
    it 'creates a signature multiple elements' do
      signature = described_class.sign(aid: '9876543210',
                                       amt: '100.5',
                                       cur: 'EUR',
                                       ref: '1234567890')
      expect(signature).to eq('0DA59693FF5A779CCCA3DEB4EDA3C523E2338A0E1E41544B9A316F7FFE521C58')
    end

    it 'creates a signature multiple elements' do
      signature = described_class.sign(aid: '9876543210',
                                       amt: '123.45',
                                       cur: 'EUR',
                                       ref: '1234567890')
      expect(signature).to eq('DF174E635DABBFF7897A82822521DD739AE8CC2F83D65F6448DD2FF991481EA3')
    end

    it 'creates a signature multiple elements where the order of elements is not important for the signature' do
      signature = described_class.sign(aid: '9876543210',
                                       cur: 'EUR',
                                       amt: '123.45',
                                       ref: '1234567890')
      expect(signature).to eq('DF174E635DABBFF7897A82822521DD739AE8CC2F83D65F6448DD2FF991481EA3')
    end

    it 'creates a signature for no elements - empty string' do
      signature = described_class.sign
      expect(signature).to eq('7D70A26B834D9881CC14466ECEAC8D39188FC5EF5FFAD9AB281A8327C2C0D093')
    end

    it 'creates a signature for data coming in from a notification' do
      signature = described_class.new('HbCCptYAhSbzq3uBrCnoj6W3VZZ0VlPj').
        sign(aid: '2107929767',
             amt: '299.00',
             cur: 'EUR',
             oid: '0',
             ref: '1234567890',
             res: '0',
             tid: '36713',
             tss: 'N',
             typ: 'CRDT')
      expect(signature).to eq('B17189A262BF4359A6C09F6C30A25C67A5D1F249E059ADF3137392A24744CE77')
    end
  end
end
