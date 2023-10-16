page 50188 "Selection Exam Code-CS"
{
    // version V.001-CS

    // Sr.No Emp.ID       Date       Trigger                     Remarks
    // ------------------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174   05-04-19   Release All - OnAction()    Code added for document status Release
    // 02.   CSPL-00174   05-04-19   Reopen All - OnAction()     Code added for old  document status reopen.
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Institute Code"; InstituteCode)
            {
                Caption = 'Institute Code';
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('INSTITUTE'));
            }
            /*            field("Exam Code"; ExamCode)
                        {
                            OptionCaption = 'Exam Code';
                            ApplicationArea = All;
                        }
                        field("Exam Group"; ExamGroup)
                        {
                            OptionCaption = 'ExamGroup';
                            ApplicationArea = All;
                        }*/
        }
    }

    actions
    {
        area(creation)
        {
            action("Release All")
            {
                Image = ReleaseDoc;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for document status Release::CSPL-00174::050419: Start
                    IF InstituteCode = '' THEN
                        ERROR('Please Select Institute Code !!');

                    IF CONFIRM(Text_10002Lbl, FALSE) THEN
                        IF ExamCode = ExamCode::"Internal 1" THEN BEGIN
                            InternalExamHeaderCS.Reset();
                            InternalExamHeaderCS.SETRANGE("Exam Method Code", 'IA1');
                            IF ExamGroup = ExamGroup::ODD THEN
                                InternalExamHeaderCS.SETRANGE("Exam Group", 'ODD');
                            IF ExamGroup = ExamGroup::EVEN THEN
                                InternalExamHeaderCS.SETRANGE("Exam Group", 'EVEN');
                            InternalExamHeaderCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                            InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Open);
                            IF InternalExamHeaderCS.FINDSET() THEN BEGIN
                                REPEAT
                                    InternalExamLineCS.Reset();
                                    InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
                                    IF InternalExamLineCS.FINDSET() THEN
                                        REPEAT
                                            InternalExamLineCS.Status := InternalExamLineCS.Status::Released;
                                            InternalExamLineCS.Updated := TRUE;
                                            InternalExamLineCS.MODIFY(TRUE);
                                        UNTIL InternalExamLineCS.NEXT() = 0;
                                    InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Released;
                                    InternalExamHeaderCS.Updated := TRUE;
                                    InternalExamHeaderCS.MODIFY(TRUE);
                                UNTIL InternalExamHeaderCS.NEXT() = 0;
                                MESSAGE('All Documents Released Successfully !!');
                            END ELSE
                                ERROR('Documents Already Released !!');
                        END ELSE
                            IF ExamCode = ExamCode::"Internal 2" THEN BEGIN
                                InternalExamHeaderCS.Reset();
                                InternalExamHeaderCS.SETRANGE("Exam Method Code", 'IA2');
                                IF ExamGroup = ExamGroup::ODD THEN
                                    InternalExamHeaderCS.SETRANGE("Exam Group", 'ODD');
                                IF ExamGroup = ExamGroup::EVEN THEN
                                    InternalExamHeaderCS.SETRANGE("Exam Group", 'EVEN');
                                InternalExamHeaderCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                                InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Open);
                                IF InternalExamHeaderCS.FINDSET() THEN BEGIN
                                    REPEAT
                                        InternalExamLineCS.Reset();
                                        InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
                                        IF InternalExamLineCS.FINDSET() THEN
                                            REPEAT
                                                InternalExamLineCS.Status := InternalExamLineCS.Status::Released;
                                                InternalExamLineCS.Updated := TRUE;
                                                InternalExamLineCS.MODIFY(TRUE);
                                            UNTIL InternalExamLineCS.NEXT() = 0;
                                        InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Released;
                                        InternalExamHeaderCS.Updated := TRUE;
                                        InternalExamHeaderCS.MODIFY(TRUE);
                                    UNTIL InternalExamHeaderCS.NEXT() = 0;
                                    MESSAGE('All Documents Released Successfully !!');
                                END ELSE
                                    ERROR('Documents Already Released !!');
                            END;
                    CurrPage.Close();
                    //Code added for document status Release::CSPL-00174::050419: End
                end;
            }
            action("Reopen All")
            {
                Image = ReOpen;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Code added for old document status Reopen::CSPL-00174::050419: Start
                    IF InstituteCode = '' THEN
                        ERROR('Please Select Institute Code !!');

                    IF CONFIRM(Text_10003Lbl, FALSE) THEN
                        IF ExamCode = ExamCode::"Internal 1" THEN BEGIN
                            InternalExamHeaderCS.Reset();
                            InternalExamHeaderCS.SETRANGE("Exam Method Code", 'IA1');
                            InternalExamHeaderCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                            IF ExamGroup = ExamGroup::ODD THEN
                                InternalExamHeaderCS.SETRANGE("Exam Group", 'ODD');
                            IF ExamGroup = ExamGroup::EVEN THEN
                                InternalExamHeaderCS.SETRANGE("Exam Group", 'EVEN');
                            IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Released THEN
                                InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Released);
                            IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Published THEN
                                InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Published);
                            IF InternalExamHeaderCS.FINDSET() THEN BEGIN
                                REPEAT
                                    InternalExamLineCS.Reset();
                                    InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
                                    IF InternalExamLineCS.FINDSET() THEN
                                        REPEAT
                                            InternalExamLineCS.Status := InternalExamLineCS.Status::Open;
                                            InternalExamLineCS.Updated := TRUE;
                                            InternalExamLineCS.MODIFY(TRUE);
                                        UNTIL InternalExamLineCS.NEXT() = 0;
                                    InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Open;
                                    InternalExamHeaderCS.Updated := TRUE;
                                    InternalExamHeaderCS.MODIFY(TRUE);
                                UNTIL InternalExamHeaderCS.NEXT() = 0;
                                MESSAGE('All Documents Reopened Successfully !!');
                            END ELSE
                                ERROR('Documents Already Reopen !!');
                        END ELSE
                            IF ExamCode = ExamCode::"Internal 2" THEN BEGIN
                                InternalExamHeaderCS.Reset();
                                InternalExamHeaderCS.SETRANGE("Exam Method Code", 'IA2');
                                InternalExamHeaderCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                                IF ExamGroup = ExamGroup::ODD THEN
                                    InternalExamHeaderCS.SETRANGE("Exam Group", 'ODD');
                                IF ExamGroup = ExamGroup::EVEN THEN
                                    InternalExamHeaderCS.SETRANGE("Exam Group", 'EVEN');
                                IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Released THEN
                                    InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Released);
                                IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Published THEN
                                    InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Published);
                                IF InternalExamHeaderCS.FINDSET() THEN BEGIN
                                    REPEAT
                                        InternalExamLineCS.Reset();
                                        InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
                                        IF InternalExamLineCS.FINDSET() THEN
                                            REPEAT
                                                InternalExamLineCS.Status := InternalExamLineCS.Status::Open;
                                                InternalExamLineCS.Updated := TRUE;
                                                InternalExamLineCS.MODIFY(TRUE);
                                            UNTIL InternalExamLineCS.NEXT() = 0;
                                        InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Open;
                                        InternalExamHeaderCS.Updated := TRUE;
                                        InternalExamHeaderCS.MODIFY(TRUE);
                                    UNTIL InternalExamHeaderCS.NEXT() = 0;
                                    MESSAGE('All Documents Reopened Successfully !!');
                                END ELSE
                                    ERROR('Documents Already Reopen !!');
                            END;
                    CurrPage.Close();
                    //Code added for old document status Reopen::CSPL-00174::050419: End
                end;
            }
        }
    }

    var

        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        InstituteCode: Code[10];
        ExamCode: Option " ","Internal 1","Internal 2";
        ExamGroup: Option ODD,EVEN;
        Text_10002Lbl: Label 'Do You Want To Release All Documents ? ';
        Text_10003Lbl: Label 'Do You Want To Reopen All Documents ? ';


}