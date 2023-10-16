codeunit 50000 "Education Time Table-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   19/02/2019     GenerateCale()-Function           Code added for generate calender.
    // 02    CSPL-00059   19/02/2019     AssignDayShorting()-Function      Code added for assign day shorting .
    // 03    CSPL-00059   19/02/2019     CreateMultipleLine()-Function     Code added for create multiple line.
    // 04    CSPL-00059   19/02/2019     CheckAndUpdate()-Function         Code added for check and update data.


    trigger OnRun()
    begin



        
    end;

    procedure GenerateCale(EducationCode: Code[20]; Session: Code[20]; Dim1: Code[20]; Dim2: Code[20])
    var
        EducationCalendarEntryCS: Record "Education Calendar Entry-CS";
        CalendarOffDayCS: Record "Calendar Off Day-CS";
        CalendarHolidayCS: Record "Calendar Holiday-CS";
        EducationCalendarCS: Record "Education Calendar-CS";
        Date1: Record Date;

    begin
        //Code added for generate calender::CSPL-00059::19022019: Start
        EducationCalendarCS.GET(EducationCode, Session);
        EducationCalendarEntryCS.Reset();
        IF EducationCalendarEntryCS.FINDFIRST() THEN BEGIN
            EducationCalendarEntryCS.MODIFYALL("Off Day", FALSE);
            EducationCalendarEntryCS.MODIFYALL(Holiday, FALSE);
            EducationCalendarEntryCS.MODIFYALL(Description, '');
        END;

        Date1.RESET();
        Date1.SETFILTER("Period Type", '%1', Date1."Period Type"::Date);
        Date1.SETFILTER("Period Start", '%1..%2', EducationCalendarCS."Start Date", EducationCalendarCS."End Date");
        IF Date1.FINDSet() THEN
            REPEAT
                CLEAR(EducationCalendarEntryCS."Multi Event Exist");
                EducationCalendarEntryCS.SETFILTER(Code, '%1', EducationCalendarCS.Code);
                EducationCalendarEntryCS.SETFILTER(Date, '%1', Date1."Period Start");
                IF EducationCalendarEntryCS.FINDFIRST() THEN BEGIN
                    repeat
                        EducationCalendarEntryCS."Academic Year" := EducationCalendarCS."Academic Year";
                        EducationCalendarEntryCS.Day := Date1."Period No.";
                        EducationCalendarEntryCS."Global Dimension 1 Code" := Dim1;
                        EducationCalendarEntryCS."Global Dimension 2 Code" := Dim2;
                        EducationCalendarEntryCS."Day Order" := 0;
                        EducationCalendarEntryCS.Modify();
                    until EducationCalendarEntryCS.Next() = 0;
                end
                else begin
                    EducationCalendarEntryCS.Code := EducationCalendarCS.Code;
                    EducationCalendarEntryCS.Date := Date1."Period Start";
                    EducationCalendarEntryCS."Academic Year" := EducationCalendarCS."Academic Year";
                    EducationCalendarEntryCS.Day := Date1."Period No.";
                    EducationCalendarEntryCS."Global Dimension 1 Code" := Dim1;
                    EducationCalendarEntryCS."Global Dimension 2 Code" := Dim2;
                    EducationCalendarEntryCS."Day Order" := 0;
                    EducationCalendarEntryCS.INSERT();
                END;

            UNTIL Date1.Next() = 0;

        CalendarOffDayCS.RESET();
        CalendarOffDayCS.SETFILTER(Code, '%1', EducationCalendarCS.Code);
        IF CalendarOffDayCS.FINDSet() THEN
            REPEAT
                EducationCalendarEntryCS.RESET();
                EducationCalendarEntryCS.SETFILTER(Code, '%1', CalendarOffDayCS.Code);
                EducationCalendarEntryCS.SETFILTER(Day, '%1', CalendarOffDayCS.WeekDay);
                IF EducationCalendarEntryCS.FINDSet() THEN
                    REPEAT
                        EducationCalendarEntryCS."Off Day" := TRUE;
                        EducationCalendarEntryCS.MODIFY();
                    UNTIL EducationCalendarEntryCS.Next() = 0;
            UNTIL CalendarOffDayCS.Next() = 0;

        CalendarHolidayCS.Reset();
        CalendarHolidayCS.SETRANGE(Code, EducationCalendarCS.Code);
        IF CalendarHolidayCS.FindSet() THEN
            REPEAT
                EducationCalendarEntryCS.Reset();
                EducationCalendarEntryCS.SETRANGE(Code, CalendarHolidayCS.Code);
                EducationCalendarEntryCS.SETRANGE(Date, CalendarHolidayCS."Holiday Date");
                IF EducationCalendarEntryCS.FINDSet() THEN
                    REPEAT
                        EducationCalendarEntryCS.Holiday := TRUE;
                        EducationCalendarEntryCS.Description := CalendarHolidayCS.Description;
                        EducationCalendarEntryCS.MODIFY();
                    UNTIL EducationCalendarEntryCS.Next() = 0;
            UNTIL CalendarHolidayCS.Next() = 0
        //Code added for generate calender::CSPL-00059::19022019: End
    end;

    procedure AssignDayShorting()
    var
        PeriodHeaderCS: Record "Period Header-CS";
        EducationCalendarEntryCS: Record "Education Calendar Entry-CS";
        IntDay: Integer;
    begin
        //Code added for assign day shorting::CSPL-00059::19022019: Start
        PeriodHeaderCS.FINDFIRST();
        IntDay := 1;
        EducationCalendarEntryCS.Reset();
        EducationCalendarEntryCS.SETRANGE("Off Day", FALSE);
        EducationCalendarEntryCS.SETRANGE(Holiday, FALSE);
        IF EducationCalendarEntryCS.FINDSet() THEN
            REPEAT
                IF IntDay = PeriodHeaderCS."Working Days Per Week" + 1 THEN
                    IntDay := 1;
                EducationCalendarEntryCS."Day Order" := IntDay;
                EducationCalendarEntryCS.MODIFY();
                IntDay += 1;
            UNTIL EducationCalendarEntryCS.Next() = 0;
        //Code added for assign day shorting::CSPL-00059::19022019: End
    end;

    procedure CreateMultipleLine(EduCode: Code[20]; EduDate: Date; EventCode: Code[20]; AcademicYear: Code[20]; Session: Option FALL,SPRING,SUMMER)
    var
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Date1: Record Date;
        EducationMultiEventCalCS1: Record "Education Multi Event Cal-CS";

    begin
        //Code added for create multiple line::CSPL-00059::19022019: Start
        EducationMultiEventCalCS.GET(EduCode, EduDate, EventCode, AcademicYear, Session);
        Date1.Reset();
        Date1.SETRANGE(Date1."Period Type", Date1."Period Type"::Date);
        Date1.SETRANGE(Date1."Period Start", EducationMultiEventCalCS."Start Date", EducationMultiEventCalCS."Revised End Date");
        IF Date1.FindSet() THEN
            REPEAT
                CLEAR(EducationMultiEventCalCS1.Revised);
                EducationMultiEventCalCS1.Reset();
                EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1.Code, EduCode);
                EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1.Date, Date1."Period Start");
                EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Event Code", EventCode);
                EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Academic Year", AcademicYear);
                EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Even/Odd Semester", Session);
                IF NOT EducationMultiEventCalCS1.FINDFIRST() THEN BEGIN
                    EducationMultiEventCalCS1.Code := EducationMultiEventCalCS.Code;
                    EducationMultiEventCalCS1."Line No." := 10000 + EducationMultiEventCalCS1."Line No.";
                    EducationMultiEventCalCS1.Date := Date1."Period Start";
                    EducationMultiEventCalCS1."Event Code" := EducationMultiEventCalCS."Event Code";
                    EducationMultiEventCalCS1."Academic Year" := EducationMultiEventCalCS."Academic Year";
                    EducationMultiEventCalCS1."Event Day Calculation" := EducationMultiEventCalCS."Event Day Calculation";
                    EducationMultiEventCalCS1."Event Description" := EducationMultiEventCalCS."Event Description";
                    EducationMultiEventCalCS1.Semester := EducationMultiEventCalCS.Semester;
                    EducationMultiEventCalCS1."Subject Code" := EducationMultiEventCalCS."Subject Code";
                    EducationMultiEventCalCS1.Year := EducationMultiEventCalCS.Year;
                    EducationMultiEventCalCS1."Start Date" := EducationMultiEventCalCS."Start Date";
                    EducationMultiEventCalCS1."Revised End Date" := EducationMultiEventCalCS."Revised End Date";
                    EducationMultiEventCalCS1."End Date" := EducationMultiEventCalCS."End Date";
                    EducationMultiEventCalCS1.Revised := FALSE;
                    EducationMultiEventCalCS1."Even/Odd Semester" := Session;
                    EducationMultiEventCalCS1.Insert();
                END;
            UNTIL Date1.Next() = 0;
        MESSAGE('Event Genrated !!');
        //Code added for create multiple line::CSPL-00059::19022019: End
    end;

    procedure CheckAndUpdate(EduCode: Code[20]; EventCode: Code[20]; AcademicYear: Code[20]; Semester: Code[10]; Year1: Code[10]; CalDate: Date; StartDate: Date; Session: Option FALL,SPRING,SUMMER)
    var
        EducationMultiEventCalCS1: Record "Education Multi Event Cal-CS";
        EducationMultiEventCalCS2: Record "Education Multi Event Cal-CS";

        EducationTimeTableCS: Codeunit "Education Time Table-CS";
        Text003Lbl: Label 'Do You Want To Revise Event !!';
    begin
        //Code added for check and update data::CSPL-00059::19022019: Start

        EducationMultiEventCalCS1.Reset();
        EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1.Code, EduCode);
        EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Event Code", EventCode);
        EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Academic Year", AcademicYear);
        EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Start Date", StartDate);
        EducationMultiEventCalCS1.SETFILTER(EducationMultiEventCalCS1.Date, '<>%1', CalDate);
        EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Even/Odd Semester", Session);
        IF Semester <> '' THEN
            EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1.Semester, Semester)
        ELSE
            EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1.Year, Year1);
        IF NOT EducationMultiEventCalCS1.FINDSET() THEN
            EducationTimeTableCS.CreateMultipleLine(EduCode, CalDate, EventCode, AcademicYear, Session)

        ELSE BEGIN
            IF CONFIRM(Text003Lbl, FALSE) THEN
                EducationMultiEventCalCS1.DELETEALL();
            EducationTimeTableCS.CreateMultipleLine(EduCode, CalDate, EventCode, AcademicYear, Session);
            EducationMultiEventCalCS2.Reset();
            EducationMultiEventCalCS2.SETRANGE(EducationMultiEventCalCS2.Code, EduCode);
            EducationMultiEventCalCS2.SETRANGE(EducationMultiEventCalCS2."Event Code", EventCode);
            EducationMultiEventCalCS2.SETRANGE(EducationMultiEventCalCS2."Academic Year", AcademicYear);
            EducationMultiEventCalCS1.SETRANGE(EducationMultiEventCalCS1."Even/Odd Semester", Session);
            IF Semester <> '' THEN
                EducationMultiEventCalCS2.SETRANGE(EducationMultiEventCalCS2.Semester, Semester)
            ELSE
                EducationMultiEventCalCS2.SETRANGE(EducationMultiEventCalCS2.Year, Year1);
            IF EducationMultiEventCalCS2.FINDSET() THEN
                REPEAT
                    EducationMultiEventCalCS2.Revised := FALSE;
                    EducationMultiEventCalCS2.MODIFY();
                UNTIL EducationMultiEventCalCS2.Next() = 0;
        END;

        //Code added for check and update data::CSPL-00059::19022019: End
    end;
}