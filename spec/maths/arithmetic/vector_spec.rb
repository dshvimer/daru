describe Daru::Vector do

  let(:dv1) do 
    Daru::Vector.new [1,2,3,4], {
      name: :boozy, 
      index: [:bud, :kf, :henie, :corona]
    } 
  end
  let(:dv2) do 
    Daru::Vector.new [1,2,3,4], {
      name: :mayer, 
      index: [:obi, :wan, :kf, :corona]
    } 
  end
  let(:with_md1) do 
    Daru::Vector.new [1,2,3,nil,5,nil], {
      name: :missing, 
      index: [:a, :b, :c, :obi, :wan, :corona]
    }
  end
  let(:with_md2) do 
    Daru::Vector.new [1,2,3,nil,5,nil], {
      name: :missing, 
      index: [:obi, :wan, :corona, :a, :b, :c]
    }
  end
  let(:v1) { Daru::Vector.new([1,2,3]) }
  let(:v2) { Daru::Vector.new([1,2,3], index: [:a,:b,:c]) }

  describe "#+" do

    context "adds matching indexes of the other vector" do
      subject(:vec) { dv1 + dv2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud,:corona, :henie, :kf, :obi, :wan] }
      it { expect(vec.to_a).to eq [nil, 8, nil, 5, nil, nil] }
    end

    context "adds number to each element of the entire vector" do
      subject(:vec) { dv1 + 5 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud, :kf, :henie, :corona] }
      it { expect(vec.to_a).to eq [6, 7, 8, 9] }
    end

    context "does not add when a number is being added" do
      subject(:vec) { with_md1 + 1 }
      its(:name) { is_expected.to eq :missing }
      its(:index) { is_expected.to eq Daru::Index.new [:a, :b, :c, :obi, :wan, :corona] }
      it { expect(vec.to_a).to eq [2, 3, 4, nil, 6, nil] }
    end

    context "puts a nil when one of the operands is nil" do
      subject(:vec) { with_md1 + with_md2 }
      its(:name) { is_expected.to eq :missing }
      its(:index) { is_expected.to eq Daru::Index.new [:a, :b, :c, :corona, :obi, :wan] }
      it { expect(vec.to_a).to eq [nil, 7, nil, nil, nil, 7] }
    end

    context "appropriately adds vectors with numeric and non-numeric indexes" do
      pending "Need an alternate index implementation?"
      # subject(:vec) { v1 + v2 }
      # it { expect(v1 + v2).to eq(Daru::Vector.new([nil]*6, index: [0,1,2,:a,:b,:c])) }
    end
  end

  describe "#-" do
    context "subtracts matching indexes of the other vector" do
      subject(:vec) { dv1 - dv2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud, :corona, :henie, :kf, :obi, :wan] }
      it { expect(vec.to_a).to eq [nil, 0, nil, -1, nil, nil] }
    end

    context "subtracts number from each element of the entire vector" do
      subject(:vec) { dv1 - 5 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud,  :kf, :henie, :corona] }
      it { expect(vec.to_a).to eq [-4, -3, -2, -1] }
    end
  end

  describe "#*" do
    context "multiplies matching indexes of the other vector" do
      subject(:vec) { dv1 * dv2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud, :corona, :henie, :kf, :obi, :wan] }
      it { expect(vec.to_a).to eq [nil, 16, nil, 6, nil, nil] }
    end

    context "multiplies number to each element of the entire vector" do
      subject(:vec) { dv1 * 2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud,  :kf, :henie, :corona] }
      it { expect(vec.to_a).to eq [2, 4, 6, 8] }
    end
  end

  describe "#\/" do
    context "divides matching indicies of the other vector" do
      subject(:vec) { dv1 / dv2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud, :corona, :henie, :kf, :obi, :wan] }
      it { expect(vec.to_a).to eq [nil, 1, nil, 0, nil, nil] }
    end

    context "divides number from each element of the entire vector" do
      subject(:vec) { dv1 / 0.5 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud,  :kf, :henie, :corona] }
      it { expect(vec.to_a).to eq [2, 4, 6, 8] }
    end
  end

  describe "#%" do
    context "applies modulo operator to matching indicies of the other vector" do
      subject(:vec) { dv1 % dv2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud, :corona, :henie, :kf, :obi, :wan] }
      it { expect(vec.to_a).to eq [nil, 0, nil, 2, nil, nil] }
    end

    context "applies modulo operator to each element of the other vector" do
      subject(:vec) { dv1 % 2 }
      its(:name) { is_expected.to eq :boozy }
      its(:index) { is_expected.to eq Daru::Index.new [:bud,  :kf, :henie, :corona] }
      it { expect(vec.to_a).to eq [1, 0, 1, 0] }
    end
  end

  # context "#**" do

  # end

  # context "#exp" do
    # it "calculates exp of all numbers" do
    #   expect(@with_md1.exp.round(3)).to eq(Daru::Vector.new([2.718281828459045,
    #     7.38905609893065, 20.085536923187668, nil, 148.4131591025766, nil], index:
    #     [:a, :b, :c, :obi, :wan, :corona], name: :missing).round(3))
    # end
  # end

  # context "#abs" do
    # it "calculates abs value" do
    #   @with_md1.abs
    # end
  # end

  # context "#sqrt" do
    # it "calculates sqrt" do
    #   @with_md1.sqrt
    # end
  # end

  # context "#round" do
    # it "rounds to given precision" do
    #   @with_md1.round(2)
    # end
  # end
end
