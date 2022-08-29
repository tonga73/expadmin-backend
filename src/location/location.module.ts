import { Module } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { LocationController } from './location.controller';
import { LocationService } from './location.service';

@Module({
  controllers: [LocationController],
  providers: [PrismaService, LocationService],
  exports: [LocationService],
})
export class LocationModule {}
