page 50224 "Course Detailed-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID       Date         Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.    CSPL-00174  03-05-19     OnOpenPage()                            Code added to college wise page filter .
    // 02.    CSPL-00174  03-05-19     Course Optional Subjects - OnAction()   Code added to run the page.
    // 03.    CSPL-00174  03-05-19     <Action1000000010> - OnAction()         Code added to run the page.
    // 04.    CSPL-00174  03-05-19     <Action1000000009> - OnAction()         Code added to run the page.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Course Detailed';
    CardPageID = "Course Detail Card-CS";
    Editable = false;
    PageType = List;
    SourceTable = "Course Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Duration of Years"; Rec."Duration of Years")
                {
                    ApplicationArea = All;
                }
                field("Number of Semesters"; Rec."Number of Semesters")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Course")
            {
                Caption = '&Course';
                /*  action(Card)
                  {
                      Caption = 'Card';
                      Image = EditLines;
                      ShortCutKey = 'Shift+F7';
                      ApplicationArea = All;
                  }*/
                action(Section)
                {
                    Caption = 'Section';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page 50233;
                    RunPageLink = "Course Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Course Su&bjects")
                {
                    Caption = 'Course Su&bjects';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page 50230;
                    RunPageLink = Course = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Course Optional Subjects")
                {
                    Caption = 'Course CBCS S&ubjects';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added to run the page::CSPL-00174::030519: Start
                        AcademicsSetupCS.GET();
                        AcademicsSetupCS.TESTFIELD("Common Subject Type");
                        SubjectMasterCS.Reset();
                        SubjectMasterCS.SETFILTER("Subject Type", '<>%1', AcademicsSetupCS."Common Subject Type");
                        SubjectMasterCS.SETFILTER(Course, '%1|%2', Rec.Code, '');
                        IF PAGE.RUNMODAL(50262, SubjectMasterCS) = ACTION::LookupOK THEN;
                        //Code added to run the page::CSPL-00174::030519: End
                    end;
                }
                action("C&ourse Semester")
                {
                    Caption = 'C&ourse Semester';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added to run the page::CSPL-00174::030519: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
                            CourseSemMasterCS.Reset();
                            CourseSemMasterCS.SETFILTER("Course Code", Rec.Code);
                            IF PAGE.RUNMODAL(50083, CourseSemMasterCS) = ACTION::LookupOK THEN;
                        END ELSE
                            ERROR('This is Year basis course');
                        //Code added to run the page::CSPL-00174::030519: End
                    end;
                }
                action("Course &Year")
                {
                    Caption = 'Course &Year';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to run the page::CSPL-00174::030519: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            CourseYearMasterCS.Reset();
                            CourseYearMasterCS.SETFILTER("Course Code", Rec.Code);
                            IF PAGE.RUNMODAL(50158, CourseYearMasterCS) = ACTION::LookupOK THEN;
                        END ELSE
                            ERROR('This is semester basis course');
                        //Code added to run the page::CSPL-00174::030519: End
                    end;
                }
                action("Course Wise Faculty")
                {
                    Caption = 'Course Wise Faculty';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page 50059;
                    RunPageLink = "Course Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added to college wise page filter ::CSPL-00174::030519: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added to college wise page filter  ::CSPL-00174::030519: End
    end;

    var
        recUserSetup: Record "User Setup";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        CourseYearMasterCS: Record "Course Year Master-CS";
}