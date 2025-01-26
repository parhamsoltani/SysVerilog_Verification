module event_trig;
    event ev_1;     //declaring event ev_1
    initial begin
        fork
            //process-1, triggers the event
            begin
                #40;
                $display($time, "\t Triggering The Event");
                ->ev_1;
            end

            //process-2, wait for the event to trigger
            begin
                $display($time, "\t waiting for the Event to trigger");
                @(ev_1);
                $display($time, "\t Event triggered");
            end
        join
    end
endmodule