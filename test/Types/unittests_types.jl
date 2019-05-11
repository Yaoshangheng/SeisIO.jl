# EventChannel, EventTraceData

printstyled("  Event* unit tests\n", color=:light_green)
EC1 = EventChannel()
@test isempty(EC1)

TD = EventTraceData()
@test isempty(TD)

@test EventTraceData(EC1) == EventTraceData(EventChannel())

TD1 = convert(EventTraceData, randSeisData())
TD2 = convert(EventTraceData, randSeisData())

EC1 = TD1[1]
EC1.id = "CC.VALT..BHZ"
TD1.id[2] = "CC.VALT..BHZ"
@test !isempty(EC1)

EC2 = EventChannel( az = 180*rand(),
                    baz = 180*rand(),
                    dist = 360*rand(),
                    fs = 10.0*rand(1:10),
                    gain = 10.0^rand(1:10),
                    id = "YY.MONGO..FOO",
                    loc = UTMLoc(),
                    misc = Dict{String,Any}("Dont" => "Science While Drink"),
                    name = "I Made This",
                    notes = Array{String,1}([tnote("It clipped"), tnote("It clipped again")]),
                    pha = PhaseCat("P" => SeisPha(),
                                   "S" => SeisPha(rand()*100.0,
                                                  rand()*100.0,
                                                  rand()*100.0,
                                                  rand()*100.0,
                                                  rand()*100.0,
                                                  'D')),
                    resp = GenResp(),
                    src = "foo",
                    t = Array{Int64,2}([1 1000; 2*length(EC1.x) 0]),
                    units = "m/s",
                    x = randn(2*length(EC1.x))
                  )

@test findid(EC1, TD1) == 2 == findid(TD1, EC1)
@test findid(TD2, EC1) == 0 == findid(EC1, TD2)
@test sizeof(TD1) > sizeof(EC1) > 136
@test sizeof(TD2) > sizeof(EC1) > 136

# Cross-Type Tests
C = randSeisChannel()
C.id = identity(EC1.id)
@test findid(C, TD1) == 2 == findid(TD1, C)
@test findid(TD2, C) == 0 == findid(C, TD2)

S1 = randSeisData(12)
S2 = randSeisData(12)
S1.id[11] = "CC.VALT..BHZ"
@test findid(EC1, S1) == 11 == findid(S1, EC1)
@test findid(S2, EC1) == findid(EC1, S2)