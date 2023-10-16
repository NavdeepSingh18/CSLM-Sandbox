report 50154 "Seating Arrangement1CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Seating Arrangement1CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = SORTING("Global Dimension 2 Code")
                                WHERE("Document No." = CONST('EEA/1718/00214'));

            trigger OnAfterGetRecord()
            begin
                i += 1;
                IF i = 1 THEN BEGIN
                    RoomsCS1.Reset();
                    RoomsCS1.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
                    RoomsCS1.SETRANGE("Academic Year", "Academic Year");
                    IF RoomsCS1.findfirst() THEN BEGIN
                        RoomCap := RoomsCS1."Exam Capacity";
                        "RoomNo." := RoomsCS1."Room No.";
                    END;
                END;
                CNT += 1;
                IF CNT <= RoomCap THEN BEGIN
                    "Room Alloted No." := "RoomNo.";
                    Modify();
                END ELSE BEGIN
                    CNT := 0;
                    RoomsCS.Reset();
                    RoomsCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
                    RoomsCS.SETRANGE("Academic Year", "Academic Year");
                    RoomsCS.SETRANGE("Room No.", "RoomNo.");
                    IF RoomsCS.findfirst() THEN BEGIN
                        RoomsCS."Allot For Examination" := TRUE;
                        RoomsCS.Modify();


                    END;
                    RoomsCS.Reset();
                    RoomsCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
                    RoomsCS.SETRANGE("Academic Year", "Academic Year");
                    RoomsCS.SETRANGE("Allot For Examination", FALSE);
                    IF RoomsCS.findfirst() THEN BEGIN
                        "RoomNo." := RoomsCS."Room No.";
                        RoomCap := RoomsCS."Exam Capacity";
                    END;
                    "Room Alloted No." := "RoomNo.";
                    Modify();
                    CNT += 1;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        RoomsCS: Record "Rooms-CS";
        RoomsCS1: Record "Rooms-CS";
        RoomCap: Integer;
        CNT: Integer;
        "RoomNo.": Code[20];
        i: Integer;
}

