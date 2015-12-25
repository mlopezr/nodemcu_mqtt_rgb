-- Startup function that enables aborting
function startup()
    if abort == true then
        print('startup aborted')
        return
    end
    print('Starting...')
    dofile('main.lua')
end

abort = false
tmr.alarm(0,5000,0,startup)
print('Waiting before starting. Set abort=true to abort')
