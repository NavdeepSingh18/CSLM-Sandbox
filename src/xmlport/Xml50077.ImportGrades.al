xmlport 50077 "Import Grades"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    UseRequestPage = false;


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MainStudentSubjectCS; "Main Student Subject-CS")

            {
                // RequestFilterFields = "Enrollment No", Course, Semester, "Academic Year", "Subject Code", "Start Date";
                // UseTemporary = true;
                //MainStudentSubject.SetCurrentKey("Student No.", Course, Semester, "Academic Year", 
                //"Subject Code", Section, "Start Date");
                textelement(OriginalStudentNo)
                { }
                textelement(StudentNo)
                {

                }

                textelement(StudentName)
                { }
                textelement(Course)
                {

                }
                textelement(Semester)
                {

                }
                textelement(AcademicYear)
                {

                }
                textelement(SubjectCode)
                {

                }
                textelement(StartDate)
                {

                }
                textelement(Grade)
                {

                }
                textelement(ExternalMarks)
                {

                    MinOccurs = Zero;

                }
                textelement(ExternalMax)
                {
                    MinOccurs = Zero;
                }
                textelement(ExternalPer)
                {
                    MinOccurs = Zero;
                }
                /*
                trigger OnAfterInitRecord()
                begin
                    IF SkipFirstLine = TRUE THEN BEGIN
                        SkipFirstLine := FALSE;
                        currXMLport.SKIP();
                    END;
                end;
                */
                trigger OnBeforeInsertRecord()
                var
                    MainStudentSubject: Record "Main Student Subject-CS";
                    StuMaster: Record "Student Master-CS";
                begin
                    if StudentNo <> '' then begin

                        OldGrade := '';
                        Evaluate(StartDate1, StartDate);
                        MainStudentSubject.reset();
                        //MainStudentSubject.SetCurrentKey("Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Start Date");
                        MainStudentSubject.setrange("Student No.", StudentNo);
                        MainStudentSubject.setrange(Course, Course);
                        MainStudentSubject.setrange(Semester, Semester);
                        MainStudentSubject.setrange("Academic Year", AcademicYear);
                        MainStudentSubject.setrange("Subject Code", SubjectCode);
                        MainStudentSubject.setrange("Start Date", StartDate1);
                        if MainStudentSubject.FindFirst() then begin
                            OldGrade := MainStudentSubject.Grade;
                            // MainStudentSubject.Grade := Grade;
                            MainStudentSubject.validate(Grade, Grade);
                            MainStudentSubject."Grade Confirmed" := true;
                            If MainStudentSubject.Grade IN ['AU', 'AUD', 'IP', 'INC', 'M', 'PNC', 'SC', 'UC', 'VO', 'W', 'X'] then
                                MainStudentSubject."Credits Attempt" := 0
                            Else
                                MainStudentSubject."Credits Attempt" := MainStudentSubject.Credit;


                            IF ExternalMarks <> '' then
                                Evaluate(MainStudentSubject."External Mark", ExternalMarks);

                            If ExternalMax <> '' then
                                Evaluate(MainStudentSubject."External Maximum", ExternalMax);

                            If ExternalPer <> '' then
                                Evaluate(MainStudentSubject."Percentage Obtained", ExternalPer);

                            ExtMarks := 0;
                            ExtMax := 0;
                            ExtPer := 0;

                            IF ExternalMarks <> '' then
                                Evaluate(ExtMarks, ExternalMarks);
                            If ExternalMax <> '' then
                                Evaluate(ExtMax, ExternalMax);
                            If ExternalPer <> '' then
                                Evaluate(ExtPer, ExternalPer);

                            CheckPer := 0;
                            If ExtMax <> 0 then
                                CheckPer := Round((ExtMarks / ExtMax) * 100);

                            If ExternalPer = '' then
                                MainStudentSubject."Percentage Obtained" := CheckPer;

                            IF ExternalMarks = '' then begin
                                ExtMarks := Round((ExtPer * ExtMax) / 100);
                                MainStudentSubject."External Mark" := ExtMarks;
                            end;

                            IF ExternalMax = '' then begin
                                IF ExtPer <> 0 then
                                    ExtMax := Round((ExtMarks / ExtPer) * 100);
                                MainStudentSubject."External Maximum" := ExtMax;
                            end;


                            If (CheckPer <> 0) and (ExtPer <> 0) then
                                IF CheckPer <> ExtPer then
                                    Error('Calculated External Mark percentage %1 does not match with the uploaded External Marks percentage %2', CheckPer, ExtPer);

                            MainStudentSubject.Modify();
                            PassingGrade.Reset();
                            PassingGrade.SetRange(Code, Grade);
                            PassingGrade.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            PassingGrade.SetFilter(Points, '%1', 0);
                            if PassingGrade.FindFirst() then begin
                                MainStudentSubject."Credit Earned" := 0;
                                MainStudentSubject.Modify();
                            end;
                            StudentTimelineRec.InsertRecordFun(MainStudentSubject."Student No.", MainStudentSubject."Student Name", 'For ' + MainStudentSubject.Description + ' Grade has been changed ' + OldGrade + ' to ' + Grade, UserId(), Today());
                            //11.8.2021-->Start
                            StuMaster.Reset();
                            StuMaster.SetRange("No.", StudentNo);
                            IF StuMaster.FindFirst() then begin
                                IF StuMaster."Student SFP Initiation" <> 0 then begin
                                    StuMaster.Validate(StuMaster."SAFI Sync", StuMaster."SAFI Sync"::Pending);
                                    StuMaster.Modify(True);
                                end;
                            end;
                            //11.8.2021-->END
                        end;
                    end;
                    currXMLport.Skip();
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitXmlPort()
    begin

    end;

    trigger OnPreXmlPort()
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Grade Upload Allowed" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;
        if not EditList then
            Error('You are not authorized.');
        //SkipRecord := 0;
        // SkipFirstLine := True;
    end;

    trigger OnPostXmlPort()
    begin
        Message(Text001);
    end;

    Var
        PassingGrade: Record "Grade Master-CS";
        StudentTimelineRec: Record "Student Time Line";
        SkipRecord: Integer;
        Text001: Label 'Successfully Completed.';
        StartDateN: text;
        EditList: Boolean;

        SkipFirstLine: Boolean;

        StartDate1: Date;
        OldGrade: Code[10];
        CheckPer: Decimal;
        ExtMarks: Decimal;
        ExtMax: Decimal;
        ExtPer: Decimal;


}
