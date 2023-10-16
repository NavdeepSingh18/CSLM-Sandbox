page 50082 "Semester Wise Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Semester Wise Group Master";
    Caption = 'Semester Wise Grouping';
    DataCaptionFields = Semester, "Academic Year", Term, Groups, "No. of Students", "Facilitator ID", "Home Room";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                Field(Section; Rec.Section)
                {
                    ApplicationArea = all;
                }
                Field("Subject Classification Type"; Rec."Subject Classification Type")
                {
                    ApplicationArea = all;
                }
                Field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = all;
                }
                Field("Facilitator ID"; Rec."Facilitator ID")
                {
                    ApplicationArea = all;
                }
                Field("Facilitator ID 2"; Rec."Facilitator ID 2")
                {
                    ApplicationArea = all;
                }
                Field("Facilitator ID 3"; Rec."Facilitator ID 3")
                {
                    ApplicationArea = all;
                }
                Field("Facilitator ID 4"; Rec."Facilitator ID 4")
                {
                    ApplicationArea = All;
                }
                Field("Home Room"; Rec."Home Room")
                {
                    ApplicationArea = All;
                }
                field("Blackboard Group Code"; Rec."Blackboard Group Code")//GAURAV//8.6.22//
                {
                    ApplicationArea = All;
                }
                field("Blackboard Group Name"; Rec."Blackboard Group Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Student wise Group Mapping")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                // trigger OnAction()
                // var
                //     StudentWiseGroupMapping: Page "Student Wise Group Mapping";
                // Begin
                //     Clear(StudentWiseGroupMapping);
                //     StudentWiseGroupMapping.InsertData(Semester, "Academic Year", Term, Section);
                //     StudentWiseGroupMapping.RunModal();

                // End;
            }
            // action("Blackboard Group Code")
            // {
            //     ApplicationArea = All;
            //     Image = List;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin
            //         Message('yhyj');
            //     end;
            // }
            // action("Blackboard Group Name")
            // {
            //     ApplicationArea = All;
            //     Image = List;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true; Rec.//END//
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin
            //         Message('yhyj');
            //     end;

            // }

            action("Delete Student wise Group")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                // trigger OnAction()
                // var
                //     TempRecord: Record "Temp Record";
                //     StudentMaster: Record "Student Master-CS";
                //     //StudentWiseGroupMapping: Page "Student Wise Group Details";
                //     EntryNo: Integer;
                // Begin
                //     Clear(StudentWiseGroupMapping);
                //     StudentMaster.Reset();
                //     StudentMaster.SetRange(Semester, Rec.Semester);
                //     StudentMaster.SetRange("Academic Year", Rec."Academic Year");
                //     StudentMaster.SetRange(Term, Rec.Term);
                //     StudentMaster.SetRange(Section, Rec.Groups);
                //     IF StudentMaster.FindSet() then begin
                //         repeat
                //             TempRecord.Reset();
                //             IF TempRecord.FindLast() then
                //                 EntryNo := TempRecord."Entry No" + 1
                //             Else
                //                 EntryNo := 1;

                //             TempRecord.Reset();
                //             TempRecord.Init();
                //             TempRecord."Entry No" := EntryNo;
                //             TempRecord."Student ID" := StudentMaster."No.";
                //             TempRecord."Student First Name" := StudentMaster."Student Name";
                //             TempRecord."Course UID" := StudentMaster."Course Code";
                //             TempRecord."Enrollment No." := StudentMaster."Enrollment No.";
                //             TempRecord.Semester := StudentMaster.Semester;
                //             TempRecord.Field4 := StudentMaster."Academic Year";
                //             TempRecord.Term := StudentMaster.Term;
                //             TempRecord.Field2 := StudentMaster.Section;
                //             TempRecord."Unique ID" := UserId();
                //             TempRecord.Insert();
                //         until StudentMaster.Next() = 0;
                //     end;
                //     Commit();
                //     TempRecord.Reset();
                //     TempRecord.SetRange(Semester, Rec.Semester);
                //     TempRecord.Setrange(Field4, Rec."Academic Year");
                //     TempRecord.SetRange(Term, Rec.Term);
                //     TempRecord.SetRange(Field2, Rec.Section);
                //     TempRecord.SetRange("Unique ID", UserId());
                //     StudentWiseGroupMapping.SetTableView(TempRecord);
                //     StudentWiseGroupMapping.GetData(Rec.Semester, Rec."Academic Year", Rec.Term, Rec.Section);
                //     StudentWiseGroupMapping.RunModal();

                // End;
            }
        }
    }
}