describe 'Check Authorization API' do


  before { get '/questions/index', headers: { 'Accept': 'application/json' } }

  it 'No auth returns HTTP status 401' do
    expect(response).to have_http_status 401
  end


end

describe 'Questions API index' do
	let!(:users) {User.create(name: FFaker::Name.name)}
	let!(:token) {Tenant.create(name: FFaker::Company.name)}
	let!(:private_question) { Question.create(title: FFaker::HipsterIpsum.sentence.gsub(/\.$/, "?"),
    private: true, user: users) }
	let!(:non_private_question) { Question.create(title: FFaker::HipsterIpsum.sentence.gsub(/\.$/, "?"),
    private: false, user: users) }

	before do
		get '/questions/', {}, { 'HTTP_AUTHORIZATION' => "Token token=#{token.api_key}"}
	end

	it 'should return only non private' do
		p "Token token=#{token.api_key}"
		body = JSON.parse(response.body)
		expect(body).to eq [non_private_question.as_json]
	end

end

describe 'Query Questions API' do
	let!(:users) {User.create(name: FFaker::Name.name)}
	let!(:token) {Tenant.create(name: FFaker::Company.name)}
	let!(:question) { Question.create(title: 'Test API',
    private: false, user: users) }
    let!(:question2) { Question.create(title: 'Bleh',
    private: true, user: users) }
    context 'non private questions' do
	    before do
			get '/questions?title=test', {}, { 'HTTP_AUTHORIZATION' => "Token token=#{token.api_key}"}
		end

		it 'should query' do
			body = JSON.parse(response.body)
			expect(body).to eq [question.as_json]
		end
	end
	
	context 'query private questions' do 
		before do
			get '/questions?title=Bleh', {}, { 'HTTP_AUTHORIZATION' => "Token token=#{token.api_key}"}
		end

		it 'should 404' do
			expect(response).to have_http_status 404
		end
	end


end
