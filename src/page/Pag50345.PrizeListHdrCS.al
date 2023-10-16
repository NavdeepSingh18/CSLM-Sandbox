page 50345 "Prize List Hdr -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      <Action1000000008> - OnAction()           Code added for insert record.
    // 02    CSPL-00059   07/02/2019      <Action1000000006> - OnAction()           Code added for report run and data modification.
    // 03    CSPL-00059   07/02/2019      Select all Student for admit-OnAction()   Code added for admit card allow.
    // 04    CSPL-00059   07/02/2019      Admit Card - OnAction()                   Code added for report run .

    PageType = Card;
    SourceTable = "Award Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Prize List Hdr';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
            part("Prize Lists-CS"; "Prize Lists-CS")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Apply)
            {
                Caption = 'Apply';
                action("Get Data")
                {
                    Caption = 'Get Data';
                    Image = Find;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    //  StudentExternalHeader: Record "External Exam Header-CS";
                    // StudentExternalLine: Record "External Exam Line-CS";
                    begin
                        //Code added for insert record::CSPL-00059::07022019: Start

                        AwardLineCS.Reset();
                        AwardLineCS.SETRANGE(AwardLineCS."Document No.", Rec."No.");
                        IF AwardLineCS.FindFirst() THEN
                            AwardLineCS.DELETEALL();

                        Window.OPEN('....Processing....');
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", Rec."Course Code");
                        StudentMasterCS.SETRANGE(StudentMasterCS."Academic Year", Rec."Academic Year");
                        IF StudentMasterCS.FindFirst() THEN
                            REPEAT
                                Loop += 10000;
                                AwardLineCS.Reset();
                                AwardLineCS.INIT();
                                AwardLineCS."Document No." := Rec."No.";
                                AwardLineCS."Line No" := Loop;
                                AwardLineCS."Student No." := StudentMasterCS."No.";
                                AwardLineCS."Student Name" := StudentMasterCS."Student Name";
                                AwardLineCS."Course Code" := Rec."Course Code";
                                AwardLineCS."Academic Year" := Rec."Academic Year";
                                AwardLineCS.INSERT();
                            UNTIL StudentMasterCS.NEXT() = 0;

                        CurrPage.Update();
                        Window.Close();
                        //Code added for insert record::CSPL-00059::07022019: End
                    end;
                }
                action("Generate Fee")
                {
                    Caption = 'Generate Fee';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for report run and record modify::CSPL-00059::07022019: Start
                        Window.OPEN('..........Processing..........');
                        REPORT.RUNMODAL(REPORT::"Course Section capacity UpdtCS", TRUE, TRUE);
                        AwardLineCS."Fee Generated" := TRUE;
                        AwardLineCS.Modify();
                        Window.Close();
                        CurrPage.Update();
                        //Code added for report run and record modify::CSPL-00059::07022019: End
                    end;
                }
                action("Select all Student for admit Card")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for admit card allow ::CSPL-00059::07022019: Start
                        AwardLineCS.Reset();
                        AwardLineCS.SETRANGE(AwardLineCS."Document No.", Rec."No.");
                        IF AwardLineCS.FindFirst() THEN
                            REPEAT
                                AwardLineCS."Generate Admit Card" := TRUE;
                                AwardLineCS.Modify();
                            UNTIL AwardLineCS.NEXT() = 0;
                        CurrPage.Update();
                        //Code added for admit card allow ::CSPL-00059::07022019: End
                    end;
                }
                action("Admit Card")
                {
                    Image = Answers;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for report run ::CSPL-00059::07022019: Start
                        AwardLineCS.Reset();
                        AwardLineCS.SETRANGE(AwardLineCS."Document No.", Rec."No.");
                        IF AwardLineCS.FindFirst() THEN
                            REPORT.RUNMODAL(33049862, TRUE, TRUE, AwardLineCS);
                        //Code added for report run ::CSPL-00059::07022019: End
                    end;
                }
            }
        }
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        // AwardHeaderCS: Record "Award Header-CS";
        AwardLineCS: Record "Award Line-CS";
        Loop: Integer;
        Window: Dialog;

}