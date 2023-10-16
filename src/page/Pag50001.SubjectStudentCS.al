page 50001 "Subject Student-CS"
{
    // version V.001-CS

    // Sr.No    Emp.ID          Date         Trigger        Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.      CSPL-00174      01-01-19     OnOpenPage()   Code added to academic year wise page filter & editable or non-editable field.

    Caption = 'Subject Student';
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Main Student Subject-CS";
    SourceTableView = sorting(Level) order(ascending);

    layout
    {
        area(content)
        {
            repeater(List)
            {
                Editable = EditList;
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No.';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ToolTip = 'Enrollment No';
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ToolTip = 'Course';
                    ApplicationArea = All;
                }
                Field("Category-Course Description"; Rec."Category-Course Description")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Dean's Honor Roll"; Rec."Dean's Honor Roll")
                {
                    ApplicationArea = All;
                }


                field(TC; Rec.TC)
                {
                    ToolTip = 'TC';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec.TC then
                            Editfield := true
                        else
                            Editfield := false;
                        Currpage.Update();
                    end;
                }
                Field("School ID"; Rec."School ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                Field("Semester Break"; Rec."Semester Break")
                {
                    ApplicationArea = All;
                }


                field("Subject Type"; Rec."Subject Type")
                {
                    ToolTip = 'Subject Type';
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ToolTip = 'Subject Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    Caption = 'Student Group';
                    ApplicationArea = all;
                }
                field("Term Description"; Rec."Term Description")
                {
                    ApplicationArea = All;
                }

                Field("Non Degree"; Rec."Non Degree")
                {
                    ApplicationArea = All;
                }

                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Grade';
                    ApplicationArea = All;
                }
                field("Grade Confirmed"; Rec."Grade Confirmed")
                {
                    ApplicationArea = all;
                }
                field("Grade Book No."; Rec."Grade Book No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnDrillDown()

                    begin
                        // OpenGradeBook(Rec);
                    end;
                }

                field(Credit; Rec.Credit)
                {
                    ToolTip = 'Credit';
                    ApplicationArea = All;
                }
                field("Credit Earned"; Rec."Credit Earned")
                {
                    ToolTip = 'Credit Earned';
                    ApplicationArea = All;
                }
                field("Credits Attempt"; Rec."Credits Attempt")
                {

                    ApplicationArea = All;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ToolTip = 'Percentage Obtained';
                    ApplicationArea = All;
                }
                field("% Range"; Rec."% Range")
                {
                    ApplicationArea = all;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = all;
                    Caption = 'Recommendations / Decision';
                }
                field(Communications; Rec.Communications)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Grade Points Earned"; Rec."Credit Grade Points Earned")
                {
                    ToolTip = 'Credit Grade Points Earned';
                    ApplicationArea = All;
                }


                field(Graduation; Rec.Graduation)
                {
                    ToolTip = 'Graduation';
                    ApplicationArea = All;
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Result';
                    ApplicationArea = All;
                }
                field("Internal Mark"; Rec."Internal Mark")
                {
                    ToolTip = 'Internal Mark';
                    ApplicationArea = All;
                }
                field("External Mark"; Rec."External Mark")
                {
                    ToolTip = 'External Mark';
                    ApplicationArea = All;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ToolTip = 'Internal Maximum';
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ToolTip = 'External Maximum';
                    ApplicationArea = All;
                }

                field("Total Internal"; Rec."Total Internal")
                {
                    ToolTip = 'Total Internal';
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ToolTip = 'Total';
                    ApplicationArea = All;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ToolTip = 'Maximum Mark';
                    ApplicationArea = All;
                }




                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }

                field("Type Of Course"; Rec."Type Of Course")
                {
                    ToolTip = 'Type Of Course';
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Year';
                    ApplicationArea = All;
                }





                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'User ID';
                    ApplicationArea = All;
                }


                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = all;
                }
                field("Subject Group Description"; Rec."Subject Group Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;
                }
                field("Level Description"; Rec."Level Description")
                {
                    ApplicationArea = all;
                }
                field("Core Rotation Group"; Rec."Core Rotation Group")
                {
                    ApplicationArea = all;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = all;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = all;
                }
                field(AdClassSchedCode; Rec.AdClassSchedCode)
                {

                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {

                    ApplicationArea = All;
                }
                field("Expected End Date"; Rec."Expected End Date")
                {

                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {

                    ApplicationArea = All;
                }
                field("Date Grade Posted"; Rec."Date Grade Posted")
                {

                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {

                    ApplicationArea = All;
                }
                field("Numeric Grade"; Rec."Numeric Grade")
                {

                    ApplicationArea = All;
                }

                field("Max Students"; Rec."Max Students")
                {

                    ApplicationArea = All;
                }
                field("Roll No."; Rec."Roll No.")
                {
                    ApplicationArea = all;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Exist in Rotation"; Rec."Exist in Rotation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                action("Subject Section Allocation")
                {
                    ToolTip = 'Subject Section Allocation';
                    Image = Account;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = False;

                    RunObject = Page "Sub. Section Allocation-CS";
                    RunPageLink = "Global Dimension 2 Code" = FIELD(Course),
                                  Course = FIELD("Academic Year"),
                                  "Subject Code" = FIELD("Subject Code");
                }
                // action("Exam Data Blank & UnTick")
                // {
                //     ToolTip = 'Exam Data Blank & UnTick';
                //     ApplicationArea = All;
                //     Image = Calculate;
                //     Promoted = true;

                //     PromotedOnly = True;
                //     PromotedIsBig = true;
                //     RunObject = Page "Un Check Student Results-CS";
                // }
                action("Grade Repeater Report")
                {
                    ToolTip = 'Grade Repeater Report';
                    ApplicationArea = All;
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    Visible = False;
                    RunObject = page "Results Student-CS";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added to academic year wise page filter & editable or non-editable field::CSPL-00174::010119: Start
        AttendPercentageHeadCS.Reset();
        IF AttendPercentageHeadCS.FINDFIRST() THEN
            AddYear := AttendPercentageHeadCS."Academic Year";
        Rec.SETFILTER("Academic Year", AddYear);

        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Student Subject Permission" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;

        if Rec.TC then
            Editfield := true
        else
            Editfield := false;

        //Code added to academic year wise page filter & editable or non-editable field::CSPL-00174::010119: End
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec.TC then
            Editfield := true
        else
            Editfield := false;
    end;

    var
        UserSetup: Record "User Setup";
        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
        EditList: Boolean;
        Editfield: Boolean;
        AddYear: Code[20];

    // procedure OpenGradeBook(StudSub: Record "Main Student Subject-CS")
    // var
    //     GradeBookHdr: Record "Grade Book Header";
    //     GradeBookOpen: Page GradeBooks;
    //     GradeBookPend: Page GradeBooksPendApp;
    //     GradeBookApp: Page GradeBooksApproved;
    //     GradeBookPub: Page GradeBooksPublished;
    // begin
    //     Clear(GradeBookOpen);
    //     Clear(GradeBookPend);
    //     Clear(GradeBookApp);
    //     Clear(GradeBookPub);

    //     GradeBookHdr.Reset();
    //     GradeBookHdr.Get(StudSub."Grade Book No.");
    //     if GradeBookHdr.Status IN [GradeBookHdr.Status::Open, GradeBookHdr.Status::Rejected] then begin
    //         GradeBookOpen.SetTableView(GradeBookHdr);
    //         GradeBookOpen.Run();
    //     end
    //     else
    //         if GradeBookHdr.Status IN [GradeBookHdr.Status::"Pending For Approval"] then begin
    //             GradeBookPend.SetTableView(GradeBookHdr);
    //             GradeBookPend.Run();
    //         end
    //         else
    //             if GradeBookHdr.Status IN [GradeBookHdr.Status::Approved] then begin
    //                 GradeBookApp.SetTableView(GradeBookHdr);
    //                 GradeBookApp.Run();
    //             end
    //             else
    //                 if GradeBookHdr.Status IN [GradeBookHdr.Status::Published] then begin
    //                     GradeBookPub.SetTableView(GradeBookHdr);
    //                     GradeBookPub.Run();
    //                 end;


    // end;
}

