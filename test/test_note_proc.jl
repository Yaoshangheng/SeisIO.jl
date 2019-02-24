using Statistics
path = Base.source_dir()

S = randseisdata(2)
id_str = "XX.STA.00.EHZ"
S.id[1] = id_str

println("...annotation...")
note!(S, 1, "hi")
@test occursin("hi", S.notes[1][end])

note!(S, "poor SNR")
@test occursin("poor SNR", S.notes[2][end])

note!(S, string(id_str, " SNR OK"))
@test occursin(" SNR OK", S.notes[1][end])

println("...clearing notes...")
clear_notes!(S, 1)
@assert(length(S.notes[1]) == 1)
@test occursin("notes cleared.", S.notes[1][1])

clear_notes!(S)
for i = 1:2
  @assert(length(S.notes[i]) == 1)
  @test occursin("notes cleared.", S.notes[i][1])
end

note!(S, 2, "whee")
clear_notes!(S, id_str)
@assert (S.notes[1] != S.notes[2])

@test_throws ErrorException clear_notes!(S, "YY.STA.11.BHE")

clear_notes!(S)

println("...ungap!...")
Ngaps = [size(S.t[i],1)-2 for i =1:2]
ungap!(S)
for i = 1:2
  @test ==(size(S.t[i],1), 2)
end

println("...unscale!...")
S.gain = rand(Float64,2)
unscale!(S)
for i = 1:2
  @test ==(S.gain[i], 1.0)
end

println("...demean!...")
demean!(S)
for i = 1:2
  @test abs(mean(S.x[i])) < 1000.0*eps(Float64)
end

# for i = 1:2
#   @test ==(S.x[i][1], 0.0)
#   @test ==(S.x[i][end], 0.0)
# end

println("...accurate logging...")
for i = 1:2
  c = (Ngaps[i]>0) ? 1 : 0
  @assert(length(S.notes[i]) == (3+c))
  if c > 0
    @test occursin("ungap!", S.notes[i][2])
  end
  @test occursin("unscale!", S.notes[i][2+c])
  @test occursin("demean!", S.notes[i][3+c])
end
