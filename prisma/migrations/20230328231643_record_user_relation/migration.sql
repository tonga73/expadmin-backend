-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "Role" ADD VALUE 'PART';
ALTER TYPE "Role" ADD VALUE 'CLIENT';

-- CreateTable
CREATE TABLE "RecordsAndUser" (
    "recordId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "RecordsAndUser_pkey" PRIMARY KEY ("recordId","userId")
);

-- AddForeignKey
ALTER TABLE "RecordsAndUser" ADD CONSTRAINT "RecordsAndUser_recordId_fkey" FOREIGN KEY ("recordId") REFERENCES "Record"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecordsAndUser" ADD CONSTRAINT "RecordsAndUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
