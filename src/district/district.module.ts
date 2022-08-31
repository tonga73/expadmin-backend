import { Module } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { DistrictController } from './district.controller';
import { DistrictService } from './district.service';

@Module({
  controllers: [DistrictController],
  providers: [PrismaService, DistrictService],
  exports: [DistrictService],
})
export class DistrictModule {}
