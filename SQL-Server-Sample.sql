
/* Create sample database table */
CREATE TABLE [dbo].[MachineData](
       [ID] [int] IDENTITY(1,1)  NOT NULL,
       [MachineName] [nvarchar](150) NULL,
       [Timestamp] [datetime] NULL,
       [Temperature] [int] NULL,
PRIMARY KEY CLUSTERED 
(
       [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/* Insert sample data */
INSERT INTO MachineData (MachineName, Timestamp, Temperature) VALUES ('Machine4', GetDate(), 40);
INSERT INTO MachineData (MachineName, Timestamp, Temperature) VALUES ('Machine4', GetDate(), 42);
INSERT INTO MachineData (MachineName, Timestamp, Temperature) VALUES ('Machine4', GetDate(), 84);
INSERT INTO MachineData (MachineName, Timestamp, Temperature) VALUES ('Machine5', GetDate(), 38);
