enum 50082 "Information of processing"
{
    //ED
    Extensible = true;
    AssignmentCompatibility = true;
    /*
    Aktivan, Privremeno odjavljen, Trajno odjavljen i sl.*/

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Not considered")
    {
        Caption = 'Not considered'; //Nije uzeto u razmatranje
    }

    value(2; "Sent to the GEO")
    {
        Caption = 'Sent to the GEO'; //Poslan geometru (u slučaju dodatne potrebe za geodetskim snimanjem ili zahtjevom za ZIK)
    }
    value(3; "Return to GEO")
    {
        Caption = 'Return to GEO'; //Vraćen od geometara i čeka obradu (izrada dokumentacije)

    }
    value(4; "Solved without Inf")
    {
        Caption = 'Solved no consent was given for the possibility of connection '; //Vraćen od geometara i čeka obradu (izrada dokumentacije)
    }
    value(5; "Solved with Inf")
    {
        Caption = 'Solved no consent was given for the possibility of connection'; //Riješen, data saglasnost za mogućnost priključenja
    }
    value(6; "Sent to SGPO")
    {
        Caption = 'Sent to SGPO sector';//11.1.	Poslan sektoru SGPO

    }
    value(7; "Return from SGPO")
    {
        Caption = 'Return from SGPO sector';//11.1.	Vraćen od sektora SGPO

    }
    value(8; "Sent to SPKOP")
    {
        Caption = 'Sent to SPKOP sector';//11.1.	Poslan sektoru SPKOP

    }
    value(9; "Return from SPKOP")
    {
        Caption = 'Return from SPKOP sector';//11.1.	Vraćen od sektora SPKOP

    }
    value(10; "Sent for amendment consent of the plot owner")
    {
        Caption = 'Sent for amendment consent of the plot owner';//Poslano na dopunu - saglasnost vlasnika parcele
    }
    value(11; "Sent for finishing plotting the object")
    {
        Caption = 'Sent for finishing plotting the object';//Poslano na doradu - ucrtavanje objekta
    }
    value(12; "Addendum submitted - consent of the plot owner")
    {
        Caption = 'Addendum submitted - consent of the plot owner';//Dostavljen dodatak - saglasnost vlasnika parcele
    }
    value(13; "Addition provided object drawing")
    {
        Caption = 'Addition provided object drawing';//Dodatak predviđen - crtanje objekta
    }
    value(14; "Sent for replenishment other")
    {
        Caption = 'Sent for replenishment other';//Poslano na dopunu - ostalo
    }
    value(15; "Submitted supplement other")
    {
        Caption = 'Submitted supplement other';//Dostavljen dodatak - ostalo
    }
    value(16; "Request throught main protocol")
    {
        Caption = 'An internal request or an external request through the main protocol that was not submitted to CZK';//Interni zahtjev ili eksterni zahtjev putem glavnog protokola koji nije dostavljen u CZK – evidentira se u Službi za dizajn i saglasnost, a ne u CZK prema broju protokola u sistemu
    }
    value(17; "Sent response to an internal or external request")
    {
        Caption = 'Sent response to an internal or external request';//Poslan odgovor na interni ili eksterni zahtjev
    }


    value(18; "Potential")
    {
        Caption = 'Potential';
    }

    value(19; "Active")
    {
        Caption = 'Active';
    }
    value(20; "Temporarily deregistered")
    {
        Caption = 'Temporarily deregistered';
    }
    value(21; "Permanently deregistered")
    {
        Caption = 'Permanently deregistered';
    }

    value(22; "Open")
    {
        Caption = 'Open';
    }

    value(23; "In Work")
    {
        Caption = 'In Work';
    }
    value(24; "Suspended")
    {
        Caption = 'Suspended';
    }
    value(25; "Done")
    {
        Caption = 'Done';
    }
    value(26; "Verified")
    {
        Caption = 'Verified';
    }
    value(27; "Reversed")
    {
        Caption = 'Reversed';
    }

    value(28; "Tracing")
    {
        Caption = 'Tracing';
    }

    value(29; "TRACED")
    {
        Caption = 'TRACED';
    }
    value(30; "Recording")
    {
        Caption = 'Recording';
    }
    value(31; "RECORDED")
    {
        Caption = 'RECORDED';
    }
    value(32; "Calculation")
    {
        Caption = 'Calculation';
    }
    value(33; "CALCULATED")
    {
        Caption = 'CALCULATED';
    }
    value(34; "Elaboration")
    {
        Caption = 'Elaboration';
    }
    value(35; "ELABORATING")
    {
        Caption = 'ELABORATING';
    }
    value(36; "ZIK")
    {
        Caption = 'ZIK';
    }
    value(37; "GIS")
    {
        Caption = 'GIS';
    }

    value(38; "Processing")
    {
        Caption = 'Processing';
    }
    value(39; "Development")
    {
        Caption = 'Development';
    }
    value(40; "Maintenance")
    {
        Caption = 'Maintenance';
    }
    value(41; "Information")
    {
        Caption = 'Information';
    }

    value(42; "Displacement")
    {
        Caption = 'Displacement';
    }
    value(43; "Shielding permanent")
    {
        Caption = 'Shielding permanent';
    }
    value(44; "Shielding temporary")
    {
        Caption = 'Shielding temporary';
    }


    value(45; "Forwarding")
    {
        Caption = 'Forwarding';
    }
    value(46; "Received")
    {
        Caption = 'Received';
    }
    value(47; "Delivered")
    {
        Caption = 'Delivered';
    }
    value(48; "Cancelled")
    {
        Caption = 'Cancelled';
    }

    value(49; "Terminated")
    {
        Caption = 'Terminated';
    }
    value(50; "Permanently inactive")
    {
        Caption = 'Permanently inactive';
    }
    value(51; "Processed")
    {
        Caption = 'Processed';
    }

    value(52; "Processed in the field")
    {
        Caption = 'Processed in the field';
    }
    value(53; "Processed ZIK")
    {
        Caption = 'Processed ZIK';
    }
    value(54; "Not processed")
    {
        Caption = 'Not processed';
    }
    value(55; "Geodetic processing")
    {
        Caption = 'Geodetic processing';
    }
    value(56; "DGM")
    {
        Caption = 'DGM';
    }
    value(57; "Not for processing")
    {
        Caption = 'Not for processing';
    }
    value(58; "Notice sent")
    {
        Caption = 'Notice sent';
    }
    value(59; "Completely Realized")
    {
        Caption = 'Completely Realized';
    }
    value(60; "Partially Realized")
    {
        Caption = 'Partially Realized';
    }
    value(61; "Realized with deadline")
    {
        Caption = 'Realized with deadline';
    }
    value(62; "Not Realized Unavailable")
    {
        caption = 'Not Realized Unavailable';
    }

    value(63; "EE extension")
    {
        caption = 'EE extension';
    }
    value(64; "Field required")
    {
        caption = 'Field required';
    }
    value(65; "Finished - connector placed under the cap")
    {
        caption = 'Finished - connector placed under the cap';
    }
    value(66; "Finished - technical decision on displacement")
    {
        caption = 'Finished - technical decision on displacement';
    }
    value(67; "Gas off")
    {
        caption = 'Gas off';
    }
    value(68; "Doesn't allowed")
    {
        caption = 'Doesnt allowed';
    }
    value(69; "lack of time")
    {
        Caption = 'lack of time';
    }
    value(70; "postponed")
    {
        Caption = 'postponed';
    }
    value(71; "disputed")
    {
        Caption = 'disputed';
    }


}