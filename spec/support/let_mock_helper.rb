module LetMockHelper
  def let_mock(name,&block)
    let(name) do 
      stubs =
        if block
          instance_exec(mock,&block) 
        else
          {}
        end
      mock(name.to_s.capitalize,stubs)
    end
  end
end
