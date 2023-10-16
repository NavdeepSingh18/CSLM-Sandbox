report 50194 "CreateSchduleHeaderLine"
{
    Caption = 'CreateSchduleHeaderLine';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
                TotalCount := "Roster Ledger Entry".Count;
                window.Open('##1##########\\' + '###2############');
                Window.UPDATE(1, TotalCount);
            end;

            trigger OnAfterGetRecord()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                LineCount += 1;
                Window.UPDATE(2, LineCount);

                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then;

                "First Name" := StudentMaster."First Name";
                "Middle Name" := StudentMaster."Middle Name";
                "Last Name" := StudentMaster."Last Name";
                "Student Name" := StudentMaster."Student Name";

                "Rotation Description" := "Course Description";

                if "Clerkship Type" = "Clerkship Type"::Core then
                    "Elective Course Code" := '';

                if "Invoice No." <> '' then
                    "Invoice No. Updated" := true;

                if "Check No." <> '' then
                    "Check No. Updated" := true;
                Modify();

                RosterSchedulingHeader.Reset();
                RosterSchedulingHeader.SetRange("Rotation ID", "Rotation ID");
                if not RosterSchedulingHeader.FindSet() then begin
                    RosterSchedulingHeader.Init();
                    RosterSchedulingHeader."Rotation ID" := "Rotation ID";
                    RosterSchedulingHeader."Clerkship Type" := "Clerkship Type";
                    RosterSchedulingHeader."Course Code" := "Course Code";
                    RosterSchedulingHeader."Course Description" := "Course Description";
                    RosterSchedulingHeader."Academic Year" := "Academic Year";
                    RosterSchedulingHeader."Hospital ID" := "Hospital ID";
                    RosterSchedulingHeader."Hospital Name" := "Hospital Name";
                    RosterSchedulingHeader."Elective Course Code" := "Elective Course Code";
                    RosterSchedulingHeader."Rotation Description" := "Rotation Description";
                    RosterSchedulingHeader."Start Date" := "Start Date";
                    RosterSchedulingHeader."End Date" := "End Date";
                    RosterSchedulingHeader."No. of Weeks" := "Total No. of Weeks";
                    RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Published;
                    RosterSchedulingHeader.Insert();

                    RosterSchedulingLine.Init();
                    RosterSchedulingLine."Rotation ID" := "Rotation ID";
                    RosterSchedulingLine."Student No." := "Student ID";
                    RosterSchedulingLine."Student Name" := "Student Name";
                    RosterSchedulingLine."Enrollment No." := "Enrollment No.";
                    RosterSchedulingLine.Semester := Semester;
                    RosterSchedulingLine."Clerkship Type" := "Clerkship Type";
                    RosterSchedulingLine."Course Code" := "Course Code";
                    RosterSchedulingLine."Course Description" := "Course Description";
                    RosterSchedulingLine."Academic Year" := "Academic Year";
                    RosterSchedulingLine."Hospital ID" := "Hospital ID";
                    RosterSchedulingLine."Hospital Name" := "Hospital Name";
                    RosterSchedulingLine."Elective Course Code" := "Elective Course Code";
                    RosterSchedulingLine."Start Date" := "Start Date";
                    RosterSchedulingLine."End Date" := "End Date";
                    RosterSchedulingLine."No. of Weeks" := "Total No. of Weeks";
                    RosterSchedulingLine.Status := RosterSchedulingLine.Status::Published;
                    RosterSchedulingLine."Cancelled Date" := "Cancelled On";
                    RosterSchedulingLine."Cancelled By" := "Cancelled By";
                    if "Cancelled On" <> 0D then
                        RosterSchedulingLine.Status := RosterSchedulingLine.Status::Cancelled;

                    RosterSchedulingLine."Ledger Entry No." := "Entry No.";
                    RosterSchedulingLine."Entry Type" := "Entry Type";
                    RosterSchedulingLine."Estimated Rotation Cost" := "Estimated Rotation Cost";
                    RosterSchedulingLine."Total Estimated Rotation Cost" := "Total Estd. Rotation Cost";
                    // RosterSchedulingLine."Total No. of Seats" := 
                    RosterSchedulingLine."Elective Course Code" := "Elective Course Code";
                    RosterSchedulingLine."Rotation Description" := "Roster Ledger Entry"."Rotation Description";

                    RosterSchedulingLine."First Name" := "First Name";
                    RosterSchedulingLine."Last Name" := "Last Name";
                    RosterSchedulingLine."Middle Name" := "Middle Name";
                    RosterSchedulingLine."Student Name" := "Student Name";
                    // RosterSchedulingLine."Published By" := 
                    // RosterSchedulingLine."Published On" := 
                    RosterSchedulingLine.Insert();
                end else begin
                    RosterSchedulingLine.Init();
                    RosterSchedulingLine."Rotation ID" := "Rotation ID";
                    RosterSchedulingLine."Student No." := "Student ID";
                    RosterSchedulingLine."Student Name" := "Student Name";
                    RosterSchedulingLine."Enrollment No." := "Enrollment No.";
                    RosterSchedulingLine.Semester := Semester;
                    RosterSchedulingLine."Clerkship Type" := "Clerkship Type";
                    RosterSchedulingLine."Course Code" := "Course Code";
                    RosterSchedulingLine."Course Description" := "Course Description";
                    RosterSchedulingLine."Academic Year" := "Academic Year";
                    RosterSchedulingLine."Hospital ID" := "Hospital ID";
                    RosterSchedulingLine."Hospital Name" := "Hospital Name";
                    RosterSchedulingLine."Elective Course Code" := "Elective Course Code";
                    RosterSchedulingLine."Rotation Description" := "Roster Ledger Entry"."Rotation Description";
                    RosterSchedulingLine."Start Date" := "Start Date";
                    RosterSchedulingLine."End Date" := "End Date";
                    RosterSchedulingLine."No. of Weeks" := "Total No. of Weeks";
                    RosterSchedulingLine.Status := RosterSchedulingLine.Status::Published;
                    RosterSchedulingLine."Cancelled Date" := "Cancelled On";
                    RosterSchedulingLine."Cancelled By" := "Cancelled By";
                    if "Cancelled On" <> 0D then
                        RosterSchedulingLine.Status := RosterSchedulingLine.Status::Cancelled;

                    RosterSchedulingLine."Ledger Entry No." := "Entry No.";
                    RosterSchedulingLine."Entry Type" := "Entry Type";
                    RosterSchedulingLine."Estimated Rotation Cost" := "Estimated Rotation Cost";
                    RosterSchedulingLine."Total Estimated Rotation Cost" := "Total Estd. Rotation Cost";
                    RosterSchedulingLine."First Name" := "First Name";
                    RosterSchedulingLine."Last Name" := "Last Name";
                    RosterSchedulingLine."Middle Name" := "Middle Name";
                    RosterSchedulingLine."Student Name" := "Student Name";
                    // RosterSchedulingLine."Published By" := 
                    // RosterSchedulingLine."Published On" := 
                    RosterSchedulingLine.Insert();
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message('done');
            end;
        }
    }
    var
        RosterSchedulingHeader: Record "Roster Scheduling Header";
        RosterSchedulingLine: Record "Roster Scheduling Line";
        window: Dialog;
        TotalCount: Integer;
        LineCount: Integer;
    // tolll: Text;

}
