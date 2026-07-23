-- CreateEnum
CREATE TYPE "public"."Language" AS ENUM ('ENGLISH', 'TAMIL');

-- CreateEnum
CREATE TYPE "public"."FarmerType" AS ENUM ('INDIVIDUAL', 'FPO_MEMBER');

-- CreateEnum
CREATE TYPE "public"."OwnershipType" AS ENUM ('OWN', 'LEASE');

-- CreateEnum
CREATE TYPE "public"."LandUnit" AS ENUM ('ACRE', 'CENT');

-- CreateTable
CREATE TABLE "public"."User" (
    "id" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "mobileNumber" TEXT NOT NULL,
    "preferredLanguage" "public"."Language" NOT NULL DEFAULT 'TAMIL',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."FarmerProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "farmerType" "public"."FarmerType" NOT NULL,
    "uzhavanId" TEXT,
    "fpoMembershipId" TEXT,
    "aadhaarNumber" TEXT,
    "village" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "state" TEXT NOT NULL DEFAULT 'Tamil Nadu',
    "pinCode" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FarmerProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."LandDetail" (
    "id" TEXT NOT NULL,
    "farmerProfileId" TEXT NOT NULL,
    "ownershipType" "public"."OwnershipType" NOT NULL,
    "landArea" DECIMAL(10,2) NOT NULL,
    "landUnit" "public"."LandUnit" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LandDetail_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_mobileNumber_key" ON "public"."User"("mobileNumber");

-- CreateIndex
CREATE UNIQUE INDEX "FarmerProfile_userId_key" ON "public"."FarmerProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "LandDetail_farmerProfileId_key" ON "public"."LandDetail"("farmerProfileId");

-- AddForeignKey
ALTER TABLE "public"."FarmerProfile" ADD CONSTRAINT "FarmerProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."LandDetail" ADD CONSTRAINT "LandDetail_farmerProfileId_fkey" FOREIGN KEY ("farmerProfileId") REFERENCES "public"."FarmerProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
